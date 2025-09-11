defmodule Esi.Api.LoyaltyStoresCorporationIdOffersGetRequiredItems do
  @moduledoc """
  Provides struct and type for a LoyaltyStoresCorporationIdOffersGetRequiredItems
  """

  @type t :: %__MODULE__{quantity: integer, type_id: integer}

  defstruct [:quantity, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [quantity: :integer, type_id: :integer]
  end
end
