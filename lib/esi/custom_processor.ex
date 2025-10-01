if Code.ensure_loaded?(OpenAPI.Processor) do
  defmodule Esi.CustomProcessor do
    use OpenAPI.Processor
    use OpenAPI.Renderer

  defp singularize(word) do
    cond do
      String.ends_with?(word, "ies") ->
        # categories -> category, companies -> company
        String.slice(word, 0, String.length(word) - 3) <> "y"
      
      String.ends_with?(word, "ves") ->
        # wolves -> wolf, knives -> knife  
        String.slice(word, 0, String.length(word) - 3) <> "f"
      
      String.ends_with?(word, "ses") ->
        # classes -> class, addresses -> address
        String.slice(word, 0, String.length(word) - 2)
      
      String.ends_with?(word, "s") and not String.ends_with?(word, "ss") ->
        # items -> item, but not class -> clas
        String.slice(word, 0, String.length(word) - 1)
      
      true ->
        word
    end
  end

  defp generate_get_function_name(name_parts, ends_with_param, base_name, path) do
    cond do
      # GET /resource/{id} -> singular resource name
      name_parts == [] and ends_with_param ->
        String.to_atom(singularize(base_name))
      
      # GET /resources -> plural resource name  
      name_parts == [] and not ends_with_param ->
        String.to_atom(base_name)
      
      # GET with subresources ending with parameter -> avoid conflicts
      length(name_parts) >= 1 and ends_with_param ->
        cond do
          String.ends_with?(base_name, "s") ->
            String.to_atom(singularize(base_name))
          String.contains?(path, "/public/") and not String.contains?(path, "/items/") ->
            String.to_atom(base_name)  # Special case for /contracts/public/{id}
          true ->
            String.to_atom("#{base_name}_item")  # Add suffix to avoid conflicts
        end
      
      # GET with subresources not ending with parameter -> keep as-is
      true ->
        String.to_atom(base_name)
    end
  end

  defp generate_post_function_name(name_parts, base_name) do
    cond do
      String.contains?(base_name, "openwindow") ->
        result = String.replace(base_name, "openwindow_", "open_") <> "_window"
        String.to_atom(result)
      
      # Only use "create_" prefix for operations that actually create resources
      name_parts == [] and is_creation_operation?(base_name) ->
        :create
      
      name_parts != [] and is_creation_operation?(base_name) ->
        String.to_atom("create_#{base_name}")
      
      # For non-creation POST operations, use the base name directly
      name_parts == [] ->
        String.to_atom(base_name)
      
      true ->
        String.to_atom(base_name)
    end
  end

  # Determine if a POST operation is actually creating a resource
  defp is_creation_operation?(base_name) do
    # Known creation operations based on EVE API patterns
    creation_patterns = [
      "contacts",      # Add contacts
      "fittings",      # Create fitting  
      "mail",          # Send/create mail
      "mail_labels",   # Create mail label
      "wings",         # Create fleet wing
      "wings_squads"   # Create fleet squad
    ]
    
    Enum.any?(creation_patterns, fn pattern ->
      String.contains?(base_name, pattern)
    end)
  end

  defp generate_method_function_name(method, name_parts, base_name) do
    case method do
      "put" ->
        if name_parts == [] do
          :update
        else
          String.to_atom("update_#{base_name}")
        end
      
      "delete" ->
        if name_parts == [] do
          :delete
        else
          String.to_atom("delete_#{base_name}")
        end
      
      "patch" ->
        if name_parts == [] do
          :update
        else
          String.to_atom("update_#{base_name}")
        end
      
      _ ->
        if name_parts == [] do
          String.to_atom(method)
        else
          String.to_atom("#{method}_#{base_name}")
        end
    end
  end


  @impl OpenAPI.Processor
  def operation_module_names(_state, operation) do
    path = operation."$oag_path"
    parts = String.split(path, "/", trim: true)
    base_module = List.first(parts) |> Macro.camelize()
    [Module.concat([base_module])]
  end

  @impl OpenAPI.Processor
  def operation_function_name(_state, operation) do
    path = operation."$oag_path"
    method = operation."$oag_path_method"
    parts = String.split(path, "/", trim: true)

    # Extract meaningful path segments (skip parameters and first segment)
    name_parts =
      parts
      |> Enum.drop(1)
      |> Enum.reject(&String.starts_with?(&1, "{"))

    # Check if path ends with a parameter (like {id})
    ends_with_param = String.starts_with?(List.last(parts), "{")
    
    # Get the base resource name from the first path segment
    first_segment = List.first(parts)
    
    # Generate function name with systematic conflict resolution
    function_name = 
      if method == "post" and String.contains?(path, "/fleets/") and String.contains?(path, "/members") do
        # Special case: Fleet members POST should be "invite"
        :invite
      else
        # Generate base name from path parts
        base_name = if name_parts == [], do: (first_segment || "resource"), else: Enum.join(name_parts, "_")
        
        # Apply method-specific naming with conflict resolution
        case method do
          "get" ->
            generate_get_function_name(name_parts, ends_with_param, base_name, path)
          
          "post" ->
            generate_post_function_name(name_parts, base_name)
          
          _ ->
            generate_method_function_name(method, name_parts, base_name)
        end
      end

    # Handle results and clean up (convert hyphens to underscores)
    case function_name do
      atom when is_atom(atom) -> 
        atom
        |> Atom.to_string()
        |> String.replace("-", "_")
        |> String.to_atom()
      string when is_binary(string) -> 
        string
        |> String.replace("-", "_")
        |> String.to_atom()
    end
  end

  # Renderer Callbacks - Generate stream functions for paginated endpoints

  @impl OpenAPI.Renderer
  def render_operation_function(state, operation) do
    if is_paginated_endpoint?(operation) do
      render_stream_function(operation)
    else
      # Use default implementation for non-paginated endpoints
      OpenAPI.Renderer.render_operation_function(state, operation)
    end
  end

  @impl OpenAPI.Renderer
  def render_default_client(state, file) do
    # Only render @default_client if there are non-paginated operations
    has_non_paginated = 
      file.operations
      |> Enum.any?(fn operation -> not is_paginated_endpoint?(operation) end)

    if has_non_paginated do
      # Use default implementation
      OpenAPI.Renderer.render_default_client(state, file)
    else
      # Don't render @default_client if all operations are paginated
      nil
    end
  end

  @impl OpenAPI.Renderer
  def render_operation_doc(_state, operation) do
    alias OpenAPI.Processor.Operation

    %Operation{docstring: docstring} = operation

    # Update docstring for paginated endpoints to mention streaming
    updated_docstring =
      if is_paginated_endpoint?(operation) do
        base_doc = String.trim_trailing(docstring)
        
        # Remove the page parameter from options if present
        base_doc = 
          base_doc
          # Remove "  * `page`" line
          |> String.replace(~r/\n\s*\* `page`\n?/, "\n")
          # Remove empty "## Options" section if only page was there
          |> String.replace(~r/\n\n## Options\n+$/, "")

        base_doc <> ~S"""


        **Note:** This endpoint is paginated and returns a stream. The stream automatically
        fetches all pages. Use `Enum` or `Stream` functions to consume the results.

        Example:
        ```elixir
        # Get all results
        results = function_name(...) |> Enum.to_list()

        # Process in chunks
        function_name(...) |> Stream.each(&process/1) |> Stream.run()
        ```
        """
      else
        docstring
      end

    quote do
      @doc unquote(updated_docstring)
    end
  end

  @impl OpenAPI.Renderer
  def render_operation_spec(state, operation) do
    alias OpenAPI.Processor.Operation
    alias OpenAPI.Processor.Operation.Param
    alias OpenAPI.Renderer.Util

    if is_paginated_endpoint?(operation) do
      # Generate custom spec for stream return type
      %Operation{
        function_name: name,
        request_path_parameters: path_params
      } = operation

      path_parameters =
        for %Param{value_type: type} <- path_params do
          quote(do: unquote(Util.to_type(state, type)))
        end

      opts = quote(do: keyword)
      arguments = path_parameters ++ [opts]

      # Return type is Enumerable.t() for streams
      return_type = quote(do: Enumerable.t())

      quote do
        @spec unquote(name)(unquote_splicing(arguments)) :: unquote(return_type)
      end
    else
      # Use default implementation for non-paginated endpoints
      OpenAPI.Renderer.render_operation_spec(state, operation)
    end
  end

  # Check if an operation has a page query parameter
  defp is_paginated_endpoint?(operation) do
    Enum.any?(operation.request_query_parameters, fn param ->
      param.name == "page"
    end)
  end

  # Generate a stream function that uses EsiEveOnline.stream_paginated
  defp render_stream_function(operation) do
    alias OpenAPI.Processor.Operation.Param

    %{
      function_name: name,
      request_path: request_path,
      request_path_parameters: path_params,
      request_query_parameters: query_params
    } = operation

    # Build function arguments
    path_parameter_arguments =
      for %Param{name: param_name} <- path_params do
        {String.to_atom(param_name), [], nil}
      end

    opts_argument = quote do: opts \\ []
    arguments = path_parameter_arguments ++ [opts_argument]

    # Build the path with proper interpolation
    # This uses the same approach as the default renderer  
    url_string = String.replace(request_path, ~r/\{([[:word:]]+)\}/, ~S'#{' <> ~S'\1}')
    url_quoted = "\"" <> url_string <> "\""
    path_with_interpolation = Code.string_to_quoted!(url_quoted)

    # Get non-page query parameters (page will be handled by stream_paginated)
    non_page_params =
      query_params
      |> Enum.reject(&(&1.name == "page"))
      |> Enum.map(fn %Param{name: param_name} -> String.to_atom(param_name) end)

    # Generate the function body
    function_body =
      if length(non_page_params) > 0 do
        # If there are other query params, we need to handle them
        quote do
          query_opts = Keyword.take(opts, unquote(non_page_params))
          all_opts = Keyword.merge(query_opts, opts)
          
          EsiEveOnline.stream_paginated(
            unquote(path_with_interpolation),
            all_opts
          )
        end
      else
        # No extra query params, just pass opts directly
        quote do
          EsiEveOnline.stream_paginated(
            unquote(path_with_interpolation),
            opts
          )
        end
      end

    # Generate the complete function definition
    quote do
      def unquote(name)(unquote_splicing(arguments)) do
        unquote(function_body)
      end
    end
  end
  end
else
  # Create a stub module when OpenAPI.Processor is not available
  defmodule Esi.CustomProcessor do
    @moduledoc """
    Custom processor for OpenAPI generation.
    
    This module is only available when the oapi_generator dependency is present.
    It's used during development for API code generation but is not needed at runtime.
    """
  end
end
