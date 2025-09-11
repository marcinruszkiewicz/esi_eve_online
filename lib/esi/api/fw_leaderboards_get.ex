defmodule Esi.Api.FwLeaderboardsGet do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsGet
  """

  @type t :: %__MODULE__{
          kills: Esi.Api.FwLeaderboardsGetKills.t(),
          victory_points: Esi.Api.FwLeaderboardsGetVictoryPoints.t()
        }

  defstruct [:kills, :victory_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      kills: {Esi.Api.FwLeaderboardsGetKills, :t},
      victory_points: {Esi.Api.FwLeaderboardsGetVictoryPoints, :t}
    ]
  end
end
