defmodule Esi.Api.Loyalty do
  @moduledoc """
  Provides API endpoint related to loyalty
  """

  @default_client Esi.Client

  @doc """
  List loyalty store offers

  Return a list of offers from a specific corporation's loyalty store

  This route expires daily at 11:05
  """
  @spec get_stores_offers(integer, keyword) ::
          {:ok, [Esi.Api.LoyaltyStoresCorporationIdOffersGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_stores_offers(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Loyalty, :get_stores_offers},
      url: "/loyalty/stores/#{corporation_id}/offers",
      method: :get,
      response: [
        {200, [{Esi.Api.LoyaltyStoresCorporationIdOffersGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
