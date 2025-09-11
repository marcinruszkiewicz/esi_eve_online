defmodule Esi.Api.KillmailsKillmailIdKillmailHashGet do
  @moduledoc """
  Provides struct and type for a KillmailsKillmailIdKillmailHashGet
  """

  @type t :: %__MODULE__{
          attackers: [Esi.Api.KillmailsKillmailIdKillmailHashGetAttackers.t()],
          killmail_id: integer,
          killmail_time: DateTime.t(),
          moon_id: integer | nil,
          solar_system_id: integer,
          victim: Esi.Api.KillmailsKillmailIdKillmailHashGetVictim.t(),
          war_id: integer | nil
        }

  defstruct [
    :attackers,
    :killmail_id,
    :killmail_time,
    :moon_id,
    :solar_system_id,
    :victim,
    :war_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attackers: [{Esi.Api.KillmailsKillmailIdKillmailHashGetAttackers, :t}],
      killmail_id: :integer,
      killmail_time: {:string, :date_time},
      moon_id: :integer,
      solar_system_id: :integer,
      victim: {Esi.Api.KillmailsKillmailIdKillmailHashGetVictim, :t},
      war_id: :integer
    ]
  end
end
