defmodule Esi.Api.Incursion do
  @moduledoc """
  Provides API endpoint related to incursion
  """

  @default_client Esi.Client

  @doc """
  List incursions

  Return a list of current incursions
  """
  @spec get_list(keyword) :: {:ok, [Esi.Api.IncursionsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_list(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Incursion, :get_list},
      url: "/incursions",
      method: :get,
      response: [{200, [{Esi.Api.IncursionsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
