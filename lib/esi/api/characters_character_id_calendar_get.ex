defmodule Esi.Api.CharactersCharacterIdCalendarGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdCalendarGet
  """

  @type t :: %__MODULE__{
          event_date: DateTime.t() | nil,
          event_id: integer | nil,
          event_response: String.t() | nil,
          importance: integer | nil,
          title: String.t() | nil
        }

  defstruct [:event_date, :event_id, :event_response, :importance, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      event_date: {:string, :date_time},
      event_id: :integer,
      event_response: {:enum, ["declined", "not_responded", "accepted", "tentative"]},
      importance: :integer,
      title: {:string, :generic}
    ]
  end
end
