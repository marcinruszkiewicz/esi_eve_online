defmodule Esi.Api.KillmailsKillmailIdKillmailHashGetAttackers do
  @moduledoc """
  Provides struct and type for a KillmailsKillmailIdKillmailHashGetAttackers
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          character_id: integer | nil,
          corporation_id: integer | nil,
          damage_done: integer,
          faction_id: integer | nil,
          final_blow: boolean,
          security_status: number,
          ship_type_id: integer | nil,
          weapon_type_id: integer | nil
        }

  defstruct [
    :alliance_id,
    :character_id,
    :corporation_id,
    :damage_done,
    :faction_id,
    :final_blow,
    :security_status,
    :ship_type_id,
    :weapon_type_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      character_id: :integer,
      corporation_id: :integer,
      damage_done: :integer,
      faction_id: :integer,
      final_blow: :boolean,
      security_status: :number,
      ship_type_id: :integer,
      weapon_type_id: :integer
    ]
  end
end
