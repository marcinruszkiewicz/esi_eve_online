defmodule Esi.Api.CharactersCharacterIdNotificationsContactsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdNotificationsContactsGet
  """

  @type t :: %__MODULE__{
          message: String.t(),
          notification_id: integer,
          send_date: DateTime.t(),
          sender_character_id: integer,
          standing_level: number
        }

  defstruct [:message, :notification_id, :send_date, :sender_character_id, :standing_level]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      message: {:string, :generic},
      notification_id: :integer,
      send_date: {:string, :date_time},
      sender_character_id: :integer,
      standing_level: :number
    ]
  end
end
