defmodule Esi.Api.CharactersCharacterIdContactsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdContactsGet
  """

  @type t :: %__MODULE__{
          contact_id: integer,
          contact_type: String.t(),
          is_blocked: boolean | nil,
          is_watched: boolean | nil,
          label_ids: [integer] | nil,
          standing: number
        }

  defstruct [:contact_id, :contact_type, :is_blocked, :is_watched, :label_ids, :standing]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contact_id: :integer,
      contact_type: {:enum, ["character", "corporation", "alliance", "faction"]},
      is_blocked: :boolean,
      is_watched: :boolean,
      label_ids: [:integer],
      standing: :number
    ]
  end
end
