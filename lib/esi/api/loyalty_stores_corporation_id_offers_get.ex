defmodule Esi.Api.LoyaltyStoresCorporationIdOffersGet do
  @moduledoc """
  Provides struct and type for a LoyaltyStoresCorporationIdOffersGet
  """

  @type t :: %__MODULE__{
          ak_cost: integer | nil,
          isk_cost: integer,
          lp_cost: integer,
          offer_id: integer,
          quantity: integer,
          required_items: [Esi.Api.LoyaltyStoresCorporationIdOffersGetRequiredItems.t()],
          type_id: integer
        }

  defstruct [:ak_cost, :isk_cost, :lp_cost, :offer_id, :quantity, :required_items, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ak_cost: :integer,
      isk_cost: :integer,
      lp_cost: :integer,
      offer_id: :integer,
      quantity: :integer,
      required_items: [{Esi.Api.LoyaltyStoresCorporationIdOffersGetRequiredItems, :t}],
      type_id: :integer
    ]
  end
end
