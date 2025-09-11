defmodule Esi.Api.Route do
  @moduledoc """
  Provides API endpoint related to route
  """

  @default_client Esi.Client

  @doc """
  Get route

  Get the systems between origin and destination

  ## Options

    * `avoid`
    * `connections`
    * `flag`

  """
  @spec get_get(integer, integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_get(destination, origin, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:avoid, :connections, :flag])

    client.request(%{
      args: [destination: destination, origin: origin],
      call: {Esi.Api.Route, :get_get},
      url: "/route/#{origin}/#{destination}",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
