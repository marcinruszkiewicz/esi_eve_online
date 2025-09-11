defmodule Esi.Api.Routes do
  @moduledoc """
  Provides API endpoint related to routes
  """

  @default_client Esi.Api.Client

  @doc """
  Get route

  Get the systems between origin and destination

  ## Options

    * `avoid`
    * `connections`
    * `flag`

  """
  @spec route(integer, integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def route(destination, origin, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:avoid, :connections, :flag])

    client.request(%{
      args: [destination: destination, origin: origin],
      call: {Esi.Api.Routes, :route},
      url: "/route/#{origin}/#{destination}",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
