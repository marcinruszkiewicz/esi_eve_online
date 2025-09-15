defmodule ESI do
  @moduledoc """
  Legacy compatibility module for ESI requests.

  This module provides the same interface as the original ESI library:
  - `ESI.request/2` and `ESI.request!/2` for basic requests
  - `ESI.request_with_headers/2` and `ESI.request_with_headers!/2` for paginated requests
  - `ESI.stream!/2` for automatic pagination

  ## Usage

  This module maintains full backward compatibility:

      # Legacy pattern still works
      ESI.API.Alliance.alliances() |> ESI.request()
      ESI.API.Character.character(12345) |> ESI.request!(token: "access_token")
      ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(100)

  Internally, these calls are mapped to the new `Esi.Client` infrastructure
  while maintaining the exact same interface and behavior.
  """

  @doc """
  Execute a request.

  ## Arguments

  - `request` -- the request (ESI.Request.t)
  - `opts` -- any additional options to set on the request

  ## Examples

      iex> ESI.API.Alliance.alliances() |> ESI.request()
      {:ok, [99005443, 99005784]}

      iex> ESI.API.Character.character(12345) |> ESI.request(token: "access_token")
      {:ok, %{"name" => "Character Name"}}

  """
  @spec request(req :: ESI.Request.t(), opts :: ESI.Request.request_opts()) ::
          {:ok, any} | {:error, any}
  def request(req, opts \\ []) do
    req
    |> ESI.Request.options(opts)
    |> ESI.Request.run()
  end

  @doc """
  Execute a request and raise an error if it is not successful.

  ## Arguments

  - `request` -- the request (ESI.Request.t)
  - `opts` -- any additional options to set on the request

  ## Examples

      iex> alliance = ESI.API.Alliance.alliance(99005443) |> ESI.request!()
      %{"name" => "Goonswarm Federation", "ticker" => "CONDI"}

  """
  @spec request!(req :: ESI.Request.t(), opts :: ESI.Request.request_opts()) :: any
  def request!(req, opts \\ []) do
    case request(req, opts) do
      {:ok, result} ->
        result

      {:error, %Esi.Error{message: message}} ->
        raise "Request failed: #{message}"

      {:error, err} ->
        raise "Request failed: #{inspect(err)}"
    end
  end

  @doc """
  Execute a request and return response with headers.

  This is primarily used for paginated requests where you need access
  to pagination headers like `x-pages`.

  ## Arguments

  - `request` -- the request (ESI.Request.t)
  - `opts` -- any additional options to set on the request

  ## Examples

      iex> {:ok, data, max_pages} = ESI.API.Universe.groups() |> ESI.request_with_headers()
      {:ok, [1, 2, 3], 2}

  """
  @spec request_with_headers(req :: ESI.Request.t(), opts :: ESI.Request.request_opts()) ::
          {:ok, any, integer} | {:error, any}
  def request_with_headers(req, opts \\ []) do
    req
    |> ESI.Request.options(opts)
    |> ESI.Request.run_with_headers()
  end

  @doc """
  Execute a request with headers and raise an error if it is not successful.

  ## Arguments

  - `request` -- the request (ESI.Request.t)  
  - `opts` -- any additional options to set on the request

  ## Examples

      iex> {data, max_pages} = ESI.API.Universe.groups() |> ESI.request_with_headers!()
      {[1, 2, 3], 2}

  """
  @spec request_with_headers!(req :: ESI.Request.t(), opts :: ESI.Request.request_opts()) :: {any, integer}
  def request_with_headers!(req, opts \\ []) do
    case request_with_headers(req, opts) do
      {:ok, result, max_pages} ->
        {result, max_pages}

      {:error, %Esi.Error{message: message}} ->
        raise "Request failed: #{message}"

      {:error, err} ->
        raise "Request failed: #{inspect(err)}"
    end
  end

  @doc """
  Generate a stream from a request, supporting automatic pagination.

  This function provides the same streaming behavior as the legacy library,
  automatically handling pagination for requests that support it.

  ## Examples

  Paginating, without `stream!`; you need to manually handle incrementing the
  `:page` option:

      iex> ESI.API.Universe.groups() |> ESI.request!() |> length()
      1000
      iex> ESI.API.Universe.groups(page: 2) |> ESI.request!() |> length()
      403

  Paginating with `stream!`, you don't have to care about `:page`:

      iex> ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(1020) |> length()
      1020

  Like any stream, you can use `Enum.to_list/1` to get all the items:

      iex> ESI.API.Universe.groups() |> ESI.stream!() |> Enum.to_list() |> length()
      1403

  It even works for requests that don't paginate:

      iex> ESI.API.Universe.bloodlines() |> ESI.stream!() |> Enum.to_list() |> length()
      18

  ## Arguments

  - `request` -- the request (ESI.Request.t)
  - `opts` -- any additional options to set on the request

  """
  @spec stream!(req :: ESI.Request.t(), opts :: ESI.Request.request_opts()) :: Enumerable.t()
  def stream!(req, opts \\ []) do
    req
    |> ESI.Request.options(opts)
    |> ESI.Request.stream!()
  end
end
