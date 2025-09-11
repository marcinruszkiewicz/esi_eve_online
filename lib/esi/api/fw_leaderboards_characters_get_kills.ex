defmodule Esi.Api.FwLeaderboardsCharactersGetKills do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCharactersGetKills
  """

  @type t :: %__MODULE__{
          active_total: [Esi.Api.FwLeaderboardsCharactersGetKillsActiveTotal.t()],
          last_week: [Esi.Api.FwLeaderboardsCharactersGetKillsLastWeek.t()],
          yesterday: [Esi.Api.FwLeaderboardsCharactersGetKillsYesterday.t()]
        }

  defstruct [:active_total, :last_week, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_total: [{Esi.Api.FwLeaderboardsCharactersGetKillsActiveTotal, :t}],
      last_week: [{Esi.Api.FwLeaderboardsCharactersGetKillsLastWeek, :t}],
      yesterday: [{Esi.Api.FwLeaderboardsCharactersGetKillsYesterday, :t}]
    ]
  end
end
