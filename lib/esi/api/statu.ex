defmodule Esi.Api.Statu do
  @moduledoc """
  Provides API endpoint related to statu
  """

  @default_client Esi.Client

  @doc """
  Retrieve the uptime and player counts

  EVE Server status
  """
  @spec get_list(keyword) :: {:ok, Esi.Api.StatusGet.t()} | {:error, Esi.Api.Error.t()}
  def get_list(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Statu, :get_list},
      url: "/status",
      method: :get,
      response: [{200, {Esi.Api.StatusGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
