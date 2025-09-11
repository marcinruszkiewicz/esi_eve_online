defmodule Esi.Api.CorporationsCorporationIdFwStatsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdFwStatsGet
  """

  @type t :: %__MODULE__{
          enlisted_on: DateTime.t() | nil,
          faction_id: integer | nil,
          kills: Esi.Api.CorporationsCorporationIdFwStatsGetKills.t(),
          pilots: integer | nil,
          victory_points: Esi.Api.CorporationsCorporationIdFwStatsGetVictoryPoints.t()
        }

  defstruct [:enlisted_on, :faction_id, :kills, :pilots, :victory_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      enlisted_on: {:string, :date_time},
      faction_id: :integer,
      kills: {Esi.Api.CorporationsCorporationIdFwStatsGetKills, :t},
      pilots: :integer,
      victory_points: {Esi.Api.CorporationsCorporationIdFwStatsGetVictoryPoints, :t}
    ]
  end
end
