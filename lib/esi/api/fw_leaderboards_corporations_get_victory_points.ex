defmodule Esi.Api.FwLeaderboardsCorporationsGetVictoryPoints do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCorporationsGetVictoryPoints
  """

  @type t :: %__MODULE__{
          active_total: [Esi.Api.FwLeaderboardsCorporationsGetVictoryPointsActiveTotal.t()],
          last_week: [Esi.Api.FwLeaderboardsCorporationsGetVictoryPointsLastWeek.t()],
          yesterday: [Esi.Api.FwLeaderboardsCorporationsGetVictoryPointsYesterday.t()]
        }

  defstruct [:active_total, :last_week, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_total: [{Esi.Api.FwLeaderboardsCorporationsGetVictoryPointsActiveTotal, :t}],
      last_week: [{Esi.Api.FwLeaderboardsCorporationsGetVictoryPointsLastWeek, :t}],
      yesterday: [{Esi.Api.FwLeaderboardsCorporationsGetVictoryPointsYesterday, :t}]
    ]
  end
end
