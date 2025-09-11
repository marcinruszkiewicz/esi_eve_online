defmodule Esi.Api.FwLeaderboardsCorporationsGetKills do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCorporationsGetKills
  """

  @type t :: %__MODULE__{
          active_total: [Esi.Api.FwLeaderboardsCorporationsGetKillsActiveTotal.t()],
          last_week: [Esi.Api.FwLeaderboardsCorporationsGetKillsLastWeek.t()],
          yesterday: [Esi.Api.FwLeaderboardsCorporationsGetKillsYesterday.t()]
        }

  defstruct [:active_total, :last_week, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_total: [{Esi.Api.FwLeaderboardsCorporationsGetKillsActiveTotal, :t}],
      last_week: [{Esi.Api.FwLeaderboardsCorporationsGetKillsLastWeek, :t}],
      yesterday: [{Esi.Api.FwLeaderboardsCorporationsGetKillsYesterday, :t}]
    ]
  end
end
