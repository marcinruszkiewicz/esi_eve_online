defmodule Esi.Api.CharactersCharacterIdMedalsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMedalsGet
  """

  @type t :: %__MODULE__{
          corporation_id: integer,
          date: DateTime.t(),
          description: String.t(),
          graphics: [Esi.Api.CharactersCharacterIdMedalsGetGraphics.t()],
          issuer_id: integer,
          medal_id: integer,
          reason: String.t(),
          status: String.t(),
          title: String.t()
        }

  defstruct [
    :corporation_id,
    :date,
    :description,
    :graphics,
    :issuer_id,
    :medal_id,
    :reason,
    :status,
    :title
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      corporation_id: :integer,
      date: {:string, :date_time},
      description: {:string, :generic},
      graphics: [{Esi.Api.CharactersCharacterIdMedalsGetGraphics, :t}],
      issuer_id: :integer,
      medal_id: :integer,
      reason: {:string, :generic},
      status: {:enum, ["public", "private"]},
      title: {:string, :generic}
    ]
  end
end
