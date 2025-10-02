defmodule Esi.Client do
  @moduledoc """
  HTTP client for ESI (EVE Swagger Interface) API.

  This module provides the core HTTP client functionality used by all generated
  API modules. It handles authentication, error processing, and request/response
  standardization.
  """

  alias Esi.Error

  @type request_options :: [
          token: String.t(),
          client: module(),
          user_agent: String.t(),
          timeout: integer(),
          retries: integer(),
          base_url: String.t()
        ]

  @type response :: {:ok, term()} | {:error, Error.t()}
  @type response_with_headers :: {:ok, term(), integer()} | {:error, Error.t()}

  @default_base_url "https://esi.evetech.net/latest"
  @default_user_agent "EsiEveOnline/1.0 (+https://github.com/marcinruszkiewicz/esi_eve_online discord:saithir)"
  @default_timeout 30_000
  @default_retries 3

  @doc """
  Makes an HTTP request to the ESI API.

  This is the main entry point used by all generated API modules.

  ## Parameters

  - `request_spec` - A map containing request details:
    - `:url` - The API endpoint path
    - `:method` - HTTP method (`:get`, `:post`, etc.)
    - `:args` - Request arguments (path params, body, etc.)
    - `:response` - Expected response format
    - `:call` - Module and function name for debugging
  - `opts` - Request options (see `t:request_options/0`)

  ## Examples

      iex> request_spec = %{
      ...>   url: "/alliances/1234",
      ...>   method: :get,
      ...>   args: [],
      ...>   response: [{200, {Esi.Api.Alliance, :t}}],
      ...>   call: {Esi.Api.Alliance, :alliance}
      ...> }
      iex> Esi.Client.request(request_spec, [])
      {:ok, %{...}}
  """
  @spec request(map(), request_options()) :: response()
  def request(request_spec, opts \\ []) do
    %{
      args: args,
      call: {_module, _function},
      method: method,
      response: response_specs,
      url: path
    } = request_spec

    # Merge options from request spec with passed options (passed options take precedence)
    merged_opts = Keyword.merge(request_spec[:opts] || [], opts)

    # Build the full URL
    base_url = merged_opts[:base_url] || @default_base_url
    full_url = base_url <> path

    # Extract request components
    {body, query_params, path_params} = extract_request_components(args)

    # Substitute path parameters
    final_url = substitute_path_params(full_url, path_params)

    # Build request options
    req_opts = build_request_options(merged_opts, body, query_params)

    # Make the HTTP request
    case make_http_request(method, final_url, req_opts) do
      {:ok, %Req.Response{body: response_body, headers: headers, status: status}} ->
        handle_response(status, response_body, headers, response_specs)

      {:error, %Req.TransportError{reason: :timeout}} ->
        {:error, Error.timeout_error()}

      {:error, %Req.TransportError{reason: reason}} ->
        {:error, Error.network_error("Network error: #{inspect(reason)}")}

      {:error, error} ->
        {:error, Error.network_error("Request failed: #{inspect(error)}")}
    end
  rescue
    error ->
      {:error, Error.network_error("Unexpected error: #{inspect(error)}")}
  end

  @doc """
  Makes an HTTP request to the ESI API and returns response with headers.

  This is primarily used for paginated requests where you need access
  to pagination headers like `x-pages`.

  ## Parameters

  - `request_spec` - A map containing request details (same as `request/2`)
  - `opts` - Request options (same as `request/2`)

  ## Returns

  `{:ok, data, max_pages}` on success, `{:error, error}` on failure.

  ## Examples

      iex> request_spec = %{
      ...>   url: "/universe/groups",
      ...>   method: :get,
      ...>   args: [],
      ...>   response: [{200, [:integer]}],
      ...>   call: {Esi.Api.Universe, :groups}
      ...> }
      iex> Esi.Client.request_with_headers(request_spec, [])
      {:ok, [1, 2, 3], 2}
  """
  @spec request_with_headers(map(), request_options()) :: response_with_headers()
  def request_with_headers(request_spec, opts \\ []) do
    %{
      args: args,
      call: {_module, _function},
      method: method,
      response: response_specs,
      url: path
    } = request_spec

    # Merge options from request spec with passed options (passed options take precedence)
    merged_opts = Keyword.merge(request_spec[:opts] || [], opts)

    # Build the full URL
    base_url = merged_opts[:base_url] || @default_base_url
    full_url = base_url <> path

    # Extract request components
    {body, query_params, path_params} = extract_request_components(args)

    # Substitute path parameters
    final_url = substitute_path_params(full_url, path_params)

    # Build request options
    req_opts = build_request_options(merged_opts, body, query_params)

    # Make the HTTP request
    case make_http_request(method, final_url, req_opts) do
      {:ok, %Req.Response{body: response_body, headers: headers, status: status}} ->
        handle_response_with_headers(status, response_body, headers, response_specs)

      {:error, %Req.TransportError{reason: :timeout}} ->
        {:error, Error.timeout_error()}

      {:error, %Req.TransportError{reason: reason}} ->
        {:error, Error.network_error("Network error: #{inspect(reason)}")}

      {:error, error} ->
        {:error, Error.network_error("Request failed: #{inspect(error)}")}
    end
  rescue
    error ->
      {:error, Error.network_error("Unexpected error: #{inspect(error)}")}
  end

  # Private functions

  defp extract_request_components(args) do
    body = Keyword.get(args, :body)
    query_params = Keyword.delete(args, :body) |> Map.new()
    path_params = Map.take(query_params, get_path_param_keys(query_params))
    query_params = Map.drop(query_params, Map.keys(path_params))

    {body, query_params, path_params}
  end

  defp get_path_param_keys(params) do
    # Common path parameter patterns in ESI
    path_keys = [
      :alliance_id,
      :character_id,
      :corporation_id,
      :fleet_id,
      :type_id,
      :system_id,
      :region_id,
      :constellation_id,
      :category_id,
      :group_id,
      :market_group_id,
      :contract_id,
      :item_id,
      :event_id,
      :mail_id,
      :contact_id,
      :fitting_id,
      :planet_id,
      :structure_id,
      :war_id,
      :killmail_id,
      :observer_id,
      :extraction_id,
      :wing_id,
      :squad_id,
      :attribute_id,
      :effect_id,
      :graphic_id,
      :icon_id,
      :race_id,
      :bloodline_id,
      :ancestry_id,
      :faction_id,
      :agent_id,
      :station_id
    ]

    Map.keys(params) |> Enum.filter(&(&1 in path_keys))
  end

  defp substitute_path_params(url, path_params) do
    Enum.reduce(path_params, url, fn {key, value}, acc ->
      String.replace(acc, "{#{key}}", to_string(value))
    end)
  end

  defp build_request_options(opts, body, query_params) do
    base_opts = [
      headers: build_headers(opts),
      params: query_params,
      receive_timeout: opts[:timeout] || @default_timeout,
      retry: :transient,
      max_retries: opts[:retries] || @default_retries
    ]

    if body do
      [{:json, body} | base_opts]
    else
      base_opts
    end
  end

  defp build_headers(opts) do
    base_headers = [
      {"accept", "application/json"},
      {"content-type", "application/json"},
      {"user-agent", opts[:user_agent] || @default_user_agent}
    ]

    case opts[:token] do
      nil -> base_headers
      token -> [{"authorization", "Bearer #{token}"} | base_headers]
    end
  end

  defp make_http_request(method, url, opts) do
    Req.request([method: method, url: url] ++ opts)
  end

  defp parse_response_body(body) when is_binary(body) do
    case Jason.decode(body) do
      {:ok, data} -> data
      # Fallback to raw body if JSON parsing fails
      {:error, _} -> body
    end
  end

  defp parse_response_body(body) when is_list(body) or is_map(body) do
    # Body is already parsed (list or map)
    body
  end

  defp parse_response_body(body) do
    # Unknown body type, return as-is
    body
  end

  defp handle_successful_response(status, parsed_body, response_specs) do
    case find_response_spec(status, response_specs) do
      {^status, {_module, _type_func}} -> {:ok, parsed_body}
      {^status, [:integer]} -> {:ok, parsed_body}
      {^status, :ok} -> {:ok, parsed_body}
      {^status, _other_type} -> {:ok, parsed_body}
      {:default, _} -> {:ok, parsed_body}
      :default -> {:ok, parsed_body}
      nil -> {:ok, parsed_body}
    end
  end

  defp handle_response(status, body, _headers, response_specs) when status in 200..299 do
    parsed_body = parse_response_body(body)
    handle_successful_response(status, parsed_body, response_specs)
  end

  defp handle_response(status, body, headers, _response_specs) do
    request_id = get_header_value(headers, "x-esi-request-id")
    retry_after = get_header_value(headers, "retry-after") |> parse_retry_after()

    error =
      case {status, body} do
        {400, %{"error" => message}} ->
          Error.validation_error(message, %{body: body, status: status})

        {401, _} ->
          Error.api_error(401, "Unauthorized - invalid or expired token", %{body: body})

        {403, _} ->
          Error.api_error(403, "Forbidden - insufficient permissions", %{body: body})

        {404, _} ->
          Error.api_error(404, "Not found", %{body: body})

        {420, _} ->
          Error.api_error(420, "Error limited - too many requests", %{body: body})

        {500, _} ->
          Error.api_error(500, "Internal server error", %{body: body})

        {502, _} ->
          Error.api_error(502, "Bad gateway", %{body: body})

        {503, _} ->
          Error.api_error(503, "Service unavailable", %{body: body})

        {status, %{"error" => message}} ->
          Error.api_error(status, message, %{body: body})

        {status, _} ->
          Error.http_error(status, "HTTP #{status}", %{body: body})
      end

    error =
      error
      |> maybe_add_request_id(request_id)
      |> maybe_add_retry_after(retry_after)

    {:error, error}
  end

  defp handle_response_with_headers(status, body, headers, response_specs)
       when status in 200..299 do
    # Parse x-pages header for pagination
    max_pages = parse_x_pages_header(headers)

    # Parse JSON response body
    parsed_body =
      case body do
        body when is_binary(body) ->
          case Jason.decode(body) do
            {:ok, data} -> data
            # Fallback to raw body if JSON parsing fails
            {:error, _} -> body
          end

        body when is_list(body) or is_map(body) ->
          # Body is already parsed (list or map)
          body

        _ ->
          # Unknown body type, return as-is
          body
      end

    # Find matching response spec
    case find_response_spec(status, response_specs) do
      {^status, {_module, _type_func}} ->
        {:ok, parsed_body, max_pages}

      {^status, [:integer]} ->
        # Handle list of integers response
        {:ok, parsed_body, max_pages}

      {^status, :ok} ->
        {:ok, parsed_body, max_pages}

      {^status, _other_type} ->
        # Handle any other response type specification
        {:ok, parsed_body, max_pages}

      {:default, _} ->
        # Default response spec
        {:ok, parsed_body, max_pages}

      :default ->
        # Simple default
        {:ok, parsed_body, max_pages}

      nil ->
        # Fallback for successful responses without specific spec
        {:ok, parsed_body, max_pages}
    end
  end

  defp handle_response_with_headers(status, body, headers, _response_specs) do
    request_id = get_header_value(headers, "x-esi-request-id")
    retry_after = get_header_value(headers, "retry-after") |> parse_retry_after()

    error =
      case {status, body} do
        {400, %{"error" => message}} ->
          Error.validation_error(message, %{body: body, status: status})

        {401, _} ->
          Error.api_error(401, "Unauthorized - invalid or expired token", %{body: body})

        {403, _} ->
          Error.api_error(403, "Forbidden - insufficient permissions", %{body: body})

        {404, _} ->
          Error.api_error(404, "Not found", %{body: body})

        {420, _} ->
          Error.api_error(420, "Error limited - too many requests", %{body: body})

        {500, _} ->
          Error.api_error(500, "Internal server error", %{body: body})

        {502, _} ->
          Error.api_error(502, "Bad gateway", %{body: body})

        {503, _} ->
          Error.api_error(503, "Service unavailable", %{body: body})

        {status, %{"error" => message}} ->
          Error.api_error(status, message, %{body: body})

        {status, _} ->
          Error.http_error(status, "HTTP #{status}", %{body: body})
      end

    error =
      error
      |> maybe_add_request_id(request_id)
      |> maybe_add_retry_after(retry_after)

    {:error, error}
  end

  defp find_response_spec(status, response_specs) do
    Enum.find(response_specs, fn
      {^status, _} -> true
      {:default, _} -> true
      :default -> true
      _ -> false
    end)
  end

  defp get_header_value(headers, header_name) do
    headers
    |> Enum.find(fn {name, _value} -> String.downcase(name) == String.downcase(header_name) end)
    |> case do
      # Handle list of values
      {_name, [value | _]} when is_binary(value) -> value
      # Handle single value
      {_name, value} when is_binary(value) -> value
      _ -> nil
    end
  end

  defp parse_retry_after(nil), do: nil

  defp parse_retry_after(value) when is_binary(value) do
    case Integer.parse(value) do
      {seconds, ""} -> seconds
      _ -> nil
    end
  end

  defp maybe_add_request_id(error, nil), do: error
  defp maybe_add_request_id(error, request_id), do: Error.with_request_id(error, request_id)

  defp maybe_add_retry_after(error, nil), do: error
  defp maybe_add_retry_after(error, retry_after), do: Error.with_retry_after(error, retry_after)

  defp parse_x_pages_header(headers) do
    case get_header_value(headers, "x-pages") do
      nil ->
        1

      value when is_binary(value) ->
        case Integer.parse(value) do
          {max_pages, ""} -> max_pages
          _ -> 1
        end

      _ ->
        1
    end
  end
end
