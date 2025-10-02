defmodule EsiEveOnline do
  @moduledoc """
  Main interface for the ESI (EVE Swagger Interface) Eve Online API client.

  This module provides both a modern API interface and backward compatibility
  with the legacy ESI library patterns.

  ## Quick Start

      # Get character information
      {:ok, character} = EsiEveOnline.Api.Character.character(12345)
      
      # With authentication
      {:ok, assets} = EsiEveOnline.Api.Character.assets(12345, token: "access_token")
      
      # Using the unified interface
      {:ok, character} = EsiEveOnline.get("/characters/12345")

  ## Authentication

  Most ESI endpoints require authentication via OAuth2 tokens:

      opts = [token: "your_access_token"]
      {:ok, mail} = EsiEveOnline.Api.Character.mail(12345, opts)

  ## Error Handling

  All functions return standardized `{:ok, result}` or `{:error, %Esi.Error{}}` tuples:

      case EsiEveOnline.Api.Character.character(12345) do
        {:ok, character_data} -> 
          IO.puts("Character name: \#{character_data.name}")
        {:error, %Esi.Error{type: :api_error, status: 404}} ->
          IO.puts("Character not found")
        {:error, error} ->
          IO.puts("Request failed: \#{error.message}")
      end
  """

  alias Esi.Client

  @type request_options :: Client.request_options()
  @type response :: Client.response()
  @type response_with_headers :: Client.response_with_headers()

  # Re-export the API modules for convenience
  defdelegate request(request_spec, opts \\ []), to: Client
  defdelegate request_with_headers(request_spec, opts \\ []), to: Client

  @doc """
  Makes a GET request to the specified ESI endpoint.

  ## Examples

      iex> EsiEveOnline.get("/alliances/1234")
      {:ok, %{...}}
      
      iex> EsiEveOnline.get("/characters/1234", token: "access_token")
      {:ok, %{...}}
  """
  @spec get(String.t(), request_options()) :: response()
  def get(path, opts \\ []) do
    request_spec = %{
      args: [],
      call: {__MODULE__, :get},
      method: :get,
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      url: path
    }

    Client.request(request_spec, opts)
  end

  @doc """
  Makes a GET request to the specified ESI endpoint and returns response with headers.

  This is primarily used for paginated requests where you need access
  to pagination headers like `x-pages`.

  ## Examples

      iex> EsiEveOnline.get_with_headers("/universe/groups")
      {:ok, [1, 2, 3], 2}
      
      iex> EsiEveOnline.get_with_headers("/characters/1234", token: "access_token")
      {:ok, %{...}, 1}
  """
  @spec get_with_headers(String.t(), request_options()) :: response_with_headers()
  def get_with_headers(path, opts \\ []) do
    # Extract query parameters from opts
    query_params =
      opts
      |> Keyword.drop([:token, :user_agent, :timeout, :retries, :base_url])
      |> Enum.to_list()

    request_spec = %{
      args: query_params,
      call: {__MODULE__, :get_with_headers},
      method: :get,
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      url: path
    }

    Client.request_with_headers(request_spec, opts)
  end

  @doc """
  Makes a POST request to the specified ESI endpoint.

  ## Examples

      iex> EsiEveOnline.post("/universe/names", [1234, 5678])
      {:ok, [...]}
  """
  @spec post(String.t(), term(), request_options()) :: response()
  def post(path, body, opts \\ []) do
    request_spec = %{
      args: [body: body],
      call: {__MODULE__, :post},
      method: :post,
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      url: path
    }

    Client.request(request_spec, opts)
  end

  @doc """
  Makes a PUT request to the specified ESI endpoint.
  """
  @spec put(String.t(), term(), request_options()) :: response()
  def put(path, body, opts \\ []) do
    request_spec = %{
      args: [body: body],
      call: {__MODULE__, :put},
      method: :put,
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      url: path
    }

    Client.request(request_spec, opts)
  end

  @doc """
  Makes a DELETE request to the specified ESI endpoint.
  """
  @spec delete(String.t(), request_options()) :: response()
  def delete(path, opts \\ []) do
    request_spec = %{
      args: [],
      call: {__MODULE__, :delete},
      method: :delete,
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      url: path
    }

    Client.request(request_spec, opts)
  end

  @doc """
  Makes a PATCH request to the specified ESI endpoint.
  """
  @spec patch(String.t(), term(), request_options()) :: response()
  def patch(path, body, opts \\ []) do
    request_spec = %{
      args: [body: body],
      call: {__MODULE__, :patch},
      method: :patch,
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      url: path
    }

    Client.request(request_spec, opts)
  end

  @doc """
  Convenience function that raises on error instead of returning error tuples.

  ## Examples

      iex> EsiEveOnline.get!("/alliances/1234")
      %{...}
      
      iex> EsiEveOnline.get!("/alliances/invalid")
      ** (RuntimeError) API request failed: Not found
  """
  @spec get!(String.t(), request_options()) :: term()
  def get!(path, opts \\ []) do
    case get(path, opts) do
      {:ok, result} -> result
      {:error, error} -> raise "API request failed: #{error.message}"
    end
  end

  @doc """
  POST version of `get!/2`.
  """
  @spec post!(String.t(), term(), request_options()) :: term()
  def post!(path, body, opts \\ []) do
    case post(path, body, opts) do
      {:ok, result} -> result
      {:error, error} -> raise "API request failed: #{error.message}"
    end
  end

  @doc """
  PUT version of `get!/2`.
  """
  @spec put!(String.t(), term(), request_options()) :: term()
  def put!(path, body, opts \\ []) do
    case put(path, body, opts) do
      {:ok, result} -> result
      {:error, error} -> raise "API request failed: #{error.message}"
    end
  end

  @doc """
  DELETE version of `get!/2`.
  """
  @spec delete!(String.t(), request_options()) :: term()
  def delete!(path, opts \\ []) do
    case delete(path, opts) do
      {:ok, result} -> result
      {:error, error} -> raise "API request failed: #{error.message}"
    end
  end

  @doc """
  PATCH version of `get!/2`.
  """
  @spec patch!(String.t(), term(), request_options()) :: term()
  def patch!(path, body, opts \\ []) do
    case patch(path, body, opts) do
      {:ok, result} -> result
      {:error, error} -> raise "API request failed: #{error.message}"
    end
  end

  @doc """
  Creates a stream from a paginated ESI endpoint, automatically handling pagination.

  This function provides convenient streaming for paginated endpoints like character assets,
  universe groups, etc. It automatically detects if an endpoint supports pagination and
  streams all pages as a single enumerable.

  ## Parameters

  - `path` - The ESI endpoint path (e.g., "/characters/123/assets")
  - `opts` - Request options (same as other functions)

  ## Examples

      # Stream all character assets
      EsiEveOnline.stream_paginated("/characters/12345/assets", token: "access_token")
      |> Enum.to_list()
      
      # Stream universe groups with pagination
      EsiEveOnline.stream_paginated("/universe/groups")
      |> Enum.take(50)
      
      # Works with any paginated endpoint
      EsiEveOnline.stream_paginated("/corporations/123/assets", token: "access_token")
      |> Stream.map(& &1.type_id)
      |> Enum.uniq()

  ## Notes

  - For non-paginated endpoints, this will return a single-item stream
  - The stream is lazy and will only make HTTP requests as needed
  - Each page is yielded as a separate chunk in the stream
  """
  @spec stream_paginated(String.t(), request_options()) :: Enumerable.t()
  def stream_paginated(path, opts \\ []) do
    # Extract query parameters from opts (excluding non-query options)
    query_params =
      opts
      |> Keyword.drop([:token, :user_agent, :timeout, :retries, :base_url])
      |> Enum.to_list()

    # Check if this endpoint supports pagination by looking for page parameter
    supports_pagination = supports_pagination?(path, opts)

    if supports_pagination do
      do_stream_paginated(path, query_params, opts)
    else
      do_stream_single(path, query_params, opts)
    end
  end

  @doc """
  Creates a stream from a paginated ESI endpoint and raises on error.

  This is the same as `stream_paginated/2` but raises exceptions instead of returning error tuples.

  ## Examples

      # Stream all character assets (raises on error)
      EsiEveOnline.stream!("/characters/12345/assets", token: "access_token")
      |> Enum.to_list()
  """
  @spec stream!(String.t(), request_options()) :: Enumerable.t()
  def stream!(path, opts \\ []) do
    stream_paginated(path, opts)
  end

  @doc """
  Creates a stream from a paginated ESI endpoint, automatically handling pagination.

  This is a convenience function that delegates to `stream_paginated/2`.

  ## Examples

      # Stream all character assets
      EsiEveOnline.stream("/characters/12345/assets", token: "access_token")
      |> Enum.to_list()
  """
  @spec stream(String.t(), request_options()) :: Enumerable.t()
  def stream(path, opts \\ []) do
    stream_paginated(path, opts)
  end

  # Private function to create a stream for paginated endpoints
  defp do_stream_paginated(path, query_params, opts) do
    Stream.resource(
      fn -> {path, query_params, opts, 1} end,
      &handle_paginated_stream_step/1,
      & &1
    )
  end

  defp handle_paginated_stream_step(:halt), do: {:halt, nil}

  defp handle_paginated_stream_step({path, query_params, opts, page}) do
    case get_with_headers(path, Keyword.put(query_params, :page, page) ++ opts) do
      {:ok, data, max_pages} ->
        next_page = page + 1
        next_state = determine_next_state(path, query_params, opts, next_page, max_pages)
        {data, next_state}

      {:error, error} ->
        raise "Stream request failed: #{inspect(error)}"
    end
  end

  defp determine_next_state(path, query_params, opts, next_page, max_pages) do
    if next_page > max_pages do
      :halt
    else
      {path, query_params, opts, next_page}
    end
  end

  # Private function to create a stream for non-paginated endpoints
  defp do_stream_single(path, query_params, opts) do
    Stream.resource(
      fn -> {path, query_params, opts} end,
      fn
        :halt ->
          {:halt, nil}

        {path, query_params, opts} ->
          case get(path, query_params ++ opts) do
            {:ok, data} ->
              {List.wrap(data), :halt}

            {:error, error} ->
              raise "Stream request failed: #{inspect(error)}"
          end
      end,
      & &1
    )
  end

  # Determine if an endpoint supports pagination
  # This is a heuristic based on common paginated endpoints
  defp supports_pagination?(path, opts) do
    # Check if page parameter is explicitly provided
    if Keyword.has_key?(opts, :page) do
      true
    else
      # Heuristic: common paginated endpoints
      paginated_patterns = [
        "/characters/",
        "/corporations/",
        "/universe/groups",
        "/universe/types",
        "/universe/regions",
        "/universe/constellations",
        "/universe/systems",
        "/universe/stations",
        "/universe/structures",
        "/markets/",
        "/killmails/",
        "/wars/",
        "/faction_warfare/",
        "/industry/",
        "/loyalty/",
        "/sovereignty/",
        "/incursions/",
        "/insurance/",
        "/route/",
        "/dogma/",
        "/ui/",
        "/status/",
        "/fleet/",
        "/contracts/",
        "/alliances/"
      ]

      Enum.any?(paginated_patterns, fn pattern ->
        String.contains?(path, pattern)
      end)
    end
  end
end
