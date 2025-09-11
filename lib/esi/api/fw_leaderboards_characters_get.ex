defmodule Esi.Api.FwLeaderboardsCharactersGet do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCharactersGet
  """

  @type t :: %__MODULE__{
          kills: Esi.Api.FwLeaderboardsCharactersGetKills.t(),
          victory_points: Esi.Api.FwLeaderboardsCharactersGetVictoryPoints.t()
        }

  defstruct [:kills, :victory_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      kills: {Esi.Api.FwLeaderboardsCharactersGetKills, :t},
      victory_points: {Esi.Api.FwLeaderboardsCharactersGetVictoryPoints, :t}
    ]
  end
end
