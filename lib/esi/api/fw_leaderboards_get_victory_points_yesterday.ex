defmodule Esi.Api.FwLeaderboardsGetVictoryPointsYesterday do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsGetVictoryPointsYesterday
  """

  @type t :: %__MODULE__{amount: integer | nil, faction_id: integer | nil}

  defstruct [:amount, :faction_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [amount: :integer, faction_id: :integer]
  end
end
