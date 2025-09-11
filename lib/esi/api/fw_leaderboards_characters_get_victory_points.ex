defmodule Esi.Api.FwLeaderboardsCharactersGetVictoryPoints do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCharactersGetVictoryPoints
  """

  @type t :: %__MODULE__{
          active_total: [Esi.Api.FwLeaderboardsCharactersGetVictoryPointsActiveTotal.t()],
          last_week: [Esi.Api.FwLeaderboardsCharactersGetVictoryPointsLastWeek.t()],
          yesterday: [Esi.Api.FwLeaderboardsCharactersGetVictoryPointsYesterday.t()]
        }

  defstruct [:active_total, :last_week, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_total: [{Esi.Api.FwLeaderboardsCharactersGetVictoryPointsActiveTotal, :t}],
      last_week: [{Esi.Api.FwLeaderboardsCharactersGetVictoryPointsLastWeek, :t}],
      yesterday: [{Esi.Api.FwLeaderboardsCharactersGetVictoryPointsYesterday, :t}]
    ]
  end
end
