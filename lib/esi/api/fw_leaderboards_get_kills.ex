defmodule Esi.Api.FwLeaderboardsGetKills do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsGetKills
  """

  @type t :: %__MODULE__{
          active_total: [Esi.Api.FwLeaderboardsGetKillsActiveTotal.t()],
          last_week: [Esi.Api.FwLeaderboardsGetKillsLastWeek.t()],
          yesterday: [Esi.Api.FwLeaderboardsGetKillsYesterday.t()]
        }

  defstruct [:active_total, :last_week, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_total: [{Esi.Api.FwLeaderboardsGetKillsActiveTotal, :t}],
      last_week: [{Esi.Api.FwLeaderboardsGetKillsLastWeek, :t}],
      yesterday: [{Esi.Api.FwLeaderboardsGetKillsYesterday, :t}]
    ]
  end
end
