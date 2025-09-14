defmodule Esi.Api.Status do
  @moduledoc """
  Provides API endpoint related to status
  """

  @default_client Esi.Client

  @doc """
  Retrieve the uptime and player counts

  EVE Server status
  """
  @spec status(keyword) :: {:ok, Esi.Api.StatusGet.t()} | {:error, Esi.Api.Error.t()}
  def status(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Status, :status},
      url: "/status",
      method: :get,
      response: [{200, {Esi.Api.StatusGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
