defmodule Esi.Api.FwLeaderboardsCorporationsGet do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCorporationsGet
  """

  @type t :: %__MODULE__{
          kills: Esi.Api.FwLeaderboardsCorporationsGetKills.t(),
          victory_points: Esi.Api.FwLeaderboardsCorporationsGetVictoryPoints.t()
        }

  defstruct [:kills, :victory_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      kills: {Esi.Api.FwLeaderboardsCorporationsGetKills, :t},
      victory_points: {Esi.Api.FwLeaderboardsCorporationsGetVictoryPoints, :t}
    ]
  end
end
