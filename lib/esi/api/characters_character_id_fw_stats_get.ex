defmodule Esi.Api.CharactersCharacterIdFwStatsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdFwStatsGet
  """

  @type t :: %__MODULE__{
          current_rank: integer | nil,
          enlisted_on: DateTime.t() | nil,
          faction_id: integer | nil,
          highest_rank: integer | nil,
          kills: Esi.Api.CharactersCharacterIdFwStatsGetKills.t(),
          victory_points: Esi.Api.CharactersCharacterIdFwStatsGetVictoryPoints.t()
        }

  defstruct [:current_rank, :enlisted_on, :faction_id, :highest_rank, :kills, :victory_points]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      current_rank: :integer,
      enlisted_on: {:string, :date_time},
      faction_id: :integer,
      highest_rank: :integer,
      kills: {Esi.Api.CharactersCharacterIdFwStatsGetKills, :t},
      victory_points: {Esi.Api.CharactersCharacterIdFwStatsGetVictoryPoints, :t}
    ]
  end
end
