defmodule ESI.Request do
  @moduledoc """
  Legacy compatibility struct for ESI.Request.

  This module provides compatibility with the legacy ESI library's request pattern:
  `ESI.API.Module.function() |> ESI.request()`

  The struct matches the legacy format exactly while internally mapping to the
  new Esi.Client infrastructure.
  """

  @enforce_keys [
    :verb,
    :path
  ]

  defstruct [
    :verb,
    :path,
    opts_schema: %{},
    opts: %{}
  ]

  @type t :: %__MODULE__{
          verb: :get | :post | :put | :delete,
          path: String.t(),
          opts_schema: %{atom => {:body | :query, :required | :optional}},
          opts: %{atom => any}
        }

  @typedoc """
  Additional request options.

  You can provide any options that the API accepts, and/or these common options:

  - `datasource` -- (DEFAULT: :tranquility) — The server name you would like data from
  - `user_agent` -- Client identifier
  - `token` -- Access token for authenticated requests
  - `page` -- Page number for paginated requests
  - `timeout` -- Request timeout in milliseconds
  - `retries` -- Number of retry attempts

  """
  @type request_opts :: [request_opt]
  @type request_opt ::
          {:datasource, :tranquility | :singularity}
          | {:user_agent, String.t()}
          | {:token, String.t()}
          | {:page, integer()}
          | {:timeout, integer()}
          | {:retries, integer()}
          | {atom, any}

  @doc """
  Add query options to a request
  """
  @spec options(req :: t(), opts :: request_opts) :: t()
  def options(req, []) do
    req
  end

  def options(req, opts) do
    %{req | opts: Map.merge(req.opts, Map.new(opts))}
  end

  @doc """
  Run a request using the new Esi.Client infrastructure.
  """
  @spec run(t) :: {:ok, any} | {:error, any}
  def run(request) do
    case validate(request) do
      :ok ->
        do_run(request)

      other ->
        other
    end
  end

  @doc """
  Run a request with headers using the new Esi.Client infrastructure.
  """
  @spec run_with_headers(t) :: {:ok, any, integer} | {:error, any}
  def run_with_headers(request) do
    case validate(request) do
      :ok ->
        do_run_with_headers(request)

      other ->
        other
    end
  end

  @doc """
  Validate that the request is ready.
  """
  @spec validate(request :: t) :: :ok | {:error, String.t()}
  def validate(request) do
    request.opts_schema
    |> Enum.reduce([], fn
      {key, {_, :required}}, acc ->
        if Map.has_key?(request.opts, key) do
          acc
        else
          [key | acc]
        end

      _, acc ->
        acc
    end)
    |> case do
      [] ->
        :ok

      [missing_one] ->
        {:error, "missing option `#{inspect(missing_one)}`"}

      missing_many ->
        detail = Enum.map_join(missing_many, ", ", &"`#{inspect(&1)}`")
        {:error, "missing options #{detail}"}
    end
  end

  # Execute request using new Esi.Client
  defp do_run(request) do
    client_opts = map_legacy_opts_to_client_opts(request.opts)

    case request.verb do
      :get ->
        EsiEveOnline.get(request.path, client_opts)

      :post ->
        body = extract_body_from_opts(request)
        EsiEveOnline.post(request.path, body, client_opts)

      :put ->
        body = extract_body_from_opts(request)
        EsiEveOnline.put(request.path, body, client_opts)

      :delete ->
        EsiEveOnline.delete(request.path, client_opts)

      :patch ->
        body = extract_body_from_opts(request)
        EsiEveOnline.patch(request.path, body, client_opts)
    end
  end

  # Execute request with headers for pagination support
  defp do_run_with_headers(request) do
    case do_run(%{request | opts: Map.put(request.opts, :return_headers, true)}) do
      {:ok, {data, headers}} ->
        pages =
          case Enum.find(headers, fn {name, _} -> String.downcase(name) == "x-pages" end) do
            {_, value} ->
              case Integer.parse(value) do
                {int_val, _} -> int_val
                _ -> 1
              end

            nil ->
              1
          end

        {:ok, data, pages}

      # Fallback for requests that don't return headers (e.g., from mocks in other tests)
      {:ok, data} ->
        {:ok, data, 1}

      {:error, error} ->
        {:error, error}
    end
  end

  # Map legacy options to new client options
  defp map_legacy_opts_to_client_opts(legacy_opts) do
    Enum.reduce(legacy_opts, [], fn
      # Ignore datasource for now
      {:datasource, _}, acc ->
        acc

      {:token, token}, acc ->
        [{:token, token} | acc]

      {:user_agent, ua}, acc ->
        [{:user_agent, ua} | acc]

      {:page, page}, acc ->
        [{:page, page} | acc]

      {:timeout, timeout}, acc ->
        [{:timeout, timeout} | acc]

      {:retries, retries}, acc ->
        [{:retries, retries} | acc]

      {:return_headers, value}, acc ->
        [{:return_headers, value} | acc]

      {key, value}, acc ->
        # Pass through other options that might be query parameters
        if is_query_param?(key) do
          [{key, value} | acc]
        else
          acc
        end
    end)
  end

  # Extract body content from legacy request options
  defp extract_body_from_opts(request) do
    body_opts =
      request.opts_schema
      |> Enum.filter(fn {_, {location, _}} -> location == :body end)
      |> Enum.map(fn {key, _} -> {key, Map.get(request.opts, key)} end)
      |> Enum.reject(fn {_, value} -> is_nil(value) end)
      |> Map.new()

    case map_size(body_opts) do
      0 -> nil
      1 -> body_opts |> Map.values() |> hd()
      _ -> body_opts
    end
  end

  # Determine if an option should be passed as a query parameter
  defp is_query_param?(key) when key in [:if_none_match, :etag, :language], do: true
  defp is_query_param?(_), do: false

  @doc """
  Generate a stream from a request, supporting automatic pagination.
  """
  @spec stream!(t()) :: Enumerable.t()
  def stream!(%{opts_schema: %{page: _}} = request) do
    request_fun = fn page ->
      request
      |> options(page: page)
      |> run_with_headers()
    end

    first_page = Map.get(request.opts, :page, 1)

    Stream.resource(
      fn -> {request_fun, first_page} end,
      fn
        :quit ->
          {:halt, nil}

        {fun, page} ->
          case fun.(page) do
            {:ok, [], _max_pages} ->
              {[], :quit}

            {:ok, data, max_pages} when is_list(data) ->
              next_page = page + 1

              if next_page > max_pages do
                {data, :quit}
              else
                {data, {fun, next_page}}
              end

            {:ok, data, _max_pages} ->
              {[data], :quit}

            {:error, err} ->
              raise "Request failed: #{inspect(err)}"
          end
      end,
      & &1
    )
  end

  def stream!(request) do
    Stream.resource(
      fn -> request end,
      fn
        :quit ->
          {:halt, nil}

        request ->
          case run(request) do
            {:ok, data} ->
              {List.wrap(data), :quit}

            {:error, err} ->
              raise "Request failed: #{inspect(err)}"
          end
      end,
      & &1
    )
  end
end
