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
      url: path,
      method: :get,
      args: [],
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      call: {__MODULE__, :get}
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
    request_spec = %{
      url: path,
      method: :get,
      args: [],
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      call: {__MODULE__, :get_with_headers}
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
      url: path,
      method: :post,
      args: [body: body],
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      call: {__MODULE__, :post}
    }
    
    Client.request(request_spec, opts)
  end

  @doc """
  Makes a PUT request to the specified ESI endpoint.
  """
  @spec put(String.t(), term(), request_options()) :: response()
  def put(path, body, opts \\ []) do
    request_spec = %{
      url: path,
      method: :put,
      args: [body: body],
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      call: {__MODULE__, :put}
    }
    
    Client.request(request_spec, opts)
  end

  @doc """
  Makes a DELETE request to the specified ESI endpoint.
  """
  @spec delete(String.t(), request_options()) :: response()
  def delete(path, opts \\ []) do
    request_spec = %{
      url: path,
      method: :delete,
      args: [],
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      call: {__MODULE__, :delete}
    }
    
    Client.request(request_spec, opts)
  end

  @doc """
  Makes a PATCH request to the specified ESI endpoint.
  """
  @spec patch(String.t(), term(), request_options()) :: response()
  def patch(path, body, opts \\ []) do
    request_spec = %{
      url: path,
      method: :patch,
      args: [body: body],
      response: [{200, :ok}, {:default, {Esi.Error, :t}}],
      call: {__MODULE__, :patch}
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
end
