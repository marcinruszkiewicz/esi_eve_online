defmodule Esi.Api.CharactersCharacterIdCalendarEventIdAttendeesGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdCalendarEventIdAttendeesGet
  """

  @type t :: %__MODULE__{character_id: integer | nil, event_response: String.t() | nil}

  defstruct [:character_id, :event_response]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      character_id: :integer,
      event_response: {:enum, ["declined", "not_responded", "accepted", "tentative"]}
    ]
  end
end
