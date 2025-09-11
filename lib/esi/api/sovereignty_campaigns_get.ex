defmodule Esi.Api.SovereigntyCampaignsGet do
  @moduledoc """
  Provides struct and type for a SovereigntyCampaignsGet
  """

  @type t :: %__MODULE__{
          attackers_score: number | nil,
          campaign_id: integer,
          constellation_id: integer,
          defender_id: integer | nil,
          defender_score: number | nil,
          event_type: String.t(),
          participants: [Esi.Api.SovereigntyCampaignsGetParticipants.t()] | nil,
          solar_system_id: integer,
          start_time: DateTime.t(),
          structure_id: integer
        }

  defstruct [
    :attackers_score,
    :campaign_id,
    :constellation_id,
    :defender_id,
    :defender_score,
    :event_type,
    :participants,
    :solar_system_id,
    :start_time,
    :structure_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attackers_score: :number,
      campaign_id: :integer,
      constellation_id: :integer,
      defender_id: :integer,
      defender_score: :number,
      event_type: {:enum, ["tcu_defense", "ihub_defense", "station_defense", "station_freeport"]},
      participants: [{Esi.Api.SovereigntyCampaignsGetParticipants, :t}],
      solar_system_id: :integer,
      start_time: {:string, :date_time},
      structure_id: :integer
    ]
  end
end
