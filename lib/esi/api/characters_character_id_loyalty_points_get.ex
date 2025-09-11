defmodule Esi.Api.CharactersCharacterIdLoyaltyPointsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdLoyaltyPointsGet
  """

  @type t :: %__MODULE__{corporation_id: integer, loyalty_points: integer}

  defstruct [:corporation_id, :loyalty_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [corporation_id: :integer, loyalty_points: :integer]
  end
end
