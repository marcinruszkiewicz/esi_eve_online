defmodule Esi.Request do
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

  @doc """
  Add query options to a request
  """
  def options(req, opts) do
    %{req | opts: Map.merge(req.opts, Map.new(opts))}
  end

  @doc """
  Run a request.
  """
  def run(request) do
    case validate(request) do
      :ok ->
        do_run(request)

      other ->
        other
    end
  end

  @doc """
  Validate that the request is ready.
  """
  def validate(request) do
    Enum.reduce(request.opts_schema, [], fn
      {key, {_, :required}}, acc ->
        case Map.has_key?(request.opts, key) do
          true ->
            acc

          false ->
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
        detail = Enum.map(missing_many, &"`#{inspect(&1)}`") |> Enum.join(", ")
        {:error, "missing options #{detail}"}
    end
  end

  defp do_run(request) do
    Esi.Api.Client.request(%{
      method: request.verb,
      url: request.path,
      args: request.opts,
      opts: request.opts
    })
  end
end
