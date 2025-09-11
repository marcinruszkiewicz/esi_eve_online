defmodule Esi.Api.FwLeaderboardsGetVictoryPoints do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsGetVictoryPoints
  """

  @type t :: %__MODULE__{
          active_total: [Esi.Api.FwLeaderboardsGetVictoryPointsActiveTotal.t()],
          last_week: [Esi.Api.FwLeaderboardsGetVictoryPointsLastWeek.t()],
          yesterday: [Esi.Api.FwLeaderboardsGetVictoryPointsYesterday.t()]
        }

  defstruct [:active_total, :last_week, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_total: [{Esi.Api.FwLeaderboardsGetVictoryPointsActiveTotal, :t}],
      last_week: [{Esi.Api.FwLeaderboardsGetVictoryPointsLastWeek, :t}],
      yesterday: [{Esi.Api.FwLeaderboardsGetVictoryPointsYesterday, :t}]
    ]
  end
end
