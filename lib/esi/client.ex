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
      url: path,
      method: method,
      args: args,
      response: response_specs,
      call: {_module, _function}
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
      {:ok, %Req.Response{status: status, body: response_body, headers: headers}} ->
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

  # Private functions

  defp extract_request_components(args) do
    body = Keyword.get(args, :body)
    query_params = Keyword.drop(args, [:body]) |> Enum.into(%{})
    path_params = Map.take(query_params, get_path_param_keys(query_params))
    query_params = Map.drop(query_params, Map.keys(path_params))
    
    {body, query_params, path_params}
  end

  defp get_path_param_keys(params) do
    # Common path parameter patterns in ESI
    path_keys = [
      :alliance_id, :character_id, :corporation_id, :fleet_id, :type_id,
      :system_id, :region_id, :constellation_id, :category_id, :group_id,
      :market_group_id, :contract_id, :item_id, :event_id, :mail_id,
      :contact_id, :fitting_id, :planet_id, :structure_id, :war_id,
      :killmail_id, :observer_id, :extraction_id, :wing_id, :squad_id,
      :attribute_id, :effect_id, :graphic_id, :icon_id, :race_id,
      :bloodline_id, :ancestry_id, :faction_id, :agent_id, :station_id
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

  defp handle_response(status, body, _headers, response_specs) when status in 200..299 do
    # Find matching response spec
    case find_response_spec(status, response_specs) do
      {^status, {_module, _type_func}} ->
        # TODO: Implement proper response deserialization based on module/type
        # For now, just return the body as-is
        {:ok, body}
      
      {^status, [:integer]} ->
        # Handle list of integers response
        {:ok, body}
      
      {^status, :ok} ->
        {:ok, body}
      
      {^status, _other_type} ->
        # Handle any other response type specification
        {:ok, body}
      
      {:default, _} ->
        # Default response spec
        {:ok, body}
      
      :default ->
        # Simple default
        {:ok, body}
      
      nil ->
        # Fallback for successful responses without specific spec
        {:ok, body}
    end
  end

  defp handle_response(status, body, headers, _response_specs) do
    request_id = get_header_value(headers, "x-esi-request-id")
    retry_after = get_header_value(headers, "retry-after") |> parse_retry_after()

    error = case {status, body} do
      {400, %{"error" => message}} ->
        Error.validation_error(message, %{status: status, body: body})
      
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
      {_name, value} -> value
      nil -> nil
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
end
