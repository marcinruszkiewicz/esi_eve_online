defmodule Esi.Api.CorporationsCorporationIdContactsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdContactsGet
  """

  @type t :: %__MODULE__{
          contact_id: integer,
          contact_type: String.t(),
          is_watched: boolean | nil,
          label_ids: [integer] | nil,
          standing: number
        }

  defstruct [:contact_id, :contact_type, :is_watched, :label_ids, :standing]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contact_id: :integer,
      contact_type: {:enum, ["character", "corporation", "alliance", "faction"]},
      is_watched: :boolean,
      label_ids: [:integer],
      standing: :number
    ]
  end
end
