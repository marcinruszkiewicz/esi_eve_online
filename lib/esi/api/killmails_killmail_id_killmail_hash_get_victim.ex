defmodule Esi.Api.KillmailsKillmailIdKillmailHashGetVictim do
  @moduledoc """
  Provides struct and type for a KillmailsKillmailIdKillmailHashGetVictim
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          character_id: integer | nil,
          corporation_id: integer | nil,
          damage_taken: integer,
          faction_id: integer | nil,
          items: [Esi.Api.KillmailsKillmailIdKillmailHashGetVictimItems.t()] | nil,
          position: Esi.Api.KillmailsKillmailIdKillmailHashGetVictimPosition.t() | nil,
          ship_type_id: integer
        }

  defstruct [
    :alliance_id,
    :character_id,
    :corporation_id,
    :damage_taken,
    :faction_id,
    :items,
    :position,
    :ship_type_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      character_id: :integer,
      corporation_id: :integer,
      damage_taken: :integer,
      faction_id: :integer,
      items: [{Esi.Api.KillmailsKillmailIdKillmailHashGetVictimItems, :t}],
      position: {Esi.Api.KillmailsKillmailIdKillmailHashGetVictimPosition, :t},
      ship_type_id: :integer
    ]
  end
end
