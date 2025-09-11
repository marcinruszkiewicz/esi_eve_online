defmodule Esi.Api.Insurance do
  @moduledoc """
  Provides API endpoint related to insurance
  """

  @default_client Esi.Client

  @doc """
  List insurance levels

  Return available insurance levels for all ship types
  """
  @spec get_prices(keyword) ::
          {:ok, [Esi.Api.InsurancePricesGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_prices(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Insurance, :get_prices},
      url: "/insurance/prices",
      method: :get,
      response: [{200, [{Esi.Api.InsurancePricesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
