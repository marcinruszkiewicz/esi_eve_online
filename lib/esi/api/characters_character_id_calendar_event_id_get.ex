defmodule Esi.Api.CharactersCharacterIdCalendarEventIdGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdCalendarEventIdGet
  """

  @type t :: %__MODULE__{
          date: DateTime.t(),
          duration: integer,
          event_id: integer,
          importance: integer,
          owner_id: integer,
          owner_name: String.t(),
          owner_type: String.t(),
          response: String.t(),
          text: String.t(),
          title: String.t()
        }

  defstruct [
    :date,
    :duration,
    :event_id,
    :importance,
    :owner_id,
    :owner_name,
    :owner_type,
    :response,
    :text,
    :title
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      date: {:string, :date_time},
      duration: :integer,
      event_id: :integer,
      importance: :integer,
      owner_id: :integer,
      owner_name: {:string, :generic},
      owner_type: {:enum, ["eve_server", "corporation", "faction", "character", "alliance"]},
      response: {:string, :generic},
      text: {:string, :generic},
      title: {:string, :generic}
    ]
  end
end
