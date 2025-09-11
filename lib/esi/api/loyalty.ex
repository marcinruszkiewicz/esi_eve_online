defmodule Esi.Api.Loyalty do
  @moduledoc """
  Provides API endpoints related to loyalty
  """

  @default_client Esi.Api.Client

  @doc """
  List loyalty store offers

  Return a list of offers from a specific corporation's loyalty store

  This route expires daily at 11:05
  """
  @spec offers(integer, keyword) ::
          {:ok, [Esi.Api.LoyaltyStoresCorporationIdOffersGet.t()]} | {:error, Esi.Api.Error.t()}
  def offers(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Loyalty, :offers},
      url: "/loyalty/stores/#{corporation_id}/offers",
      method: :get,
      response: [
        {200, [{Esi.Api.LoyaltyStoresCorporationIdOffersGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get loyalty points

  Return a list of loyalty points for all corporations the character has worked for
  """
  @spec points(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdLoyaltyPointsGet.t()]} | {:error, Esi.Api.Error.t()}
  def points(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Loyalty, :points},
      url: "/characters/#{character_id}/loyalty/points",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdLoyaltyPointsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
