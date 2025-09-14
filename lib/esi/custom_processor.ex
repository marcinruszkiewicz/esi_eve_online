defmodule Esi.CustomProcessor do
  use OpenAPI.Processor

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
    base_module = singularize(List.first(parts)) |> Macro.camelize()
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
end
