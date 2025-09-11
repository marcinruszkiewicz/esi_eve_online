defmodule Esi.Api.FwStatsGet do
  @moduledoc """
  Provides struct and type for a FwStatsGet
  """

  @type t :: %__MODULE__{
          faction_id: integer,
          kills: Esi.Api.FwStatsGetKills.t(),
          pilots: integer,
          systems_controlled: integer,
          victory_points: Esi.Api.FwStatsGetVictoryPoints.t()
        }

  defstruct [:faction_id, :kills, :pilots, :systems_controlled, :victory_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      faction_id: :integer,
      kills: {Esi.Api.FwStatsGetKills, :t},
      pilots: :integer,
      systems_controlled: :integer,
      victory_points: {Esi.Api.FwStatsGetVictoryPoints, :t}
    ]
  end
end
