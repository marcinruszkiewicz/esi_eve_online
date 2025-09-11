defmodule Esi.Api.CharactersCharacterIdGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdGet
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          birthday: DateTime.t(),
          bloodline_id: integer,
          corporation_id: integer,
          description: String.t() | nil,
          faction_id: integer | nil,
          gender: String.t(),
          name: String.t(),
          race_id: integer,
          security_status: number | nil,
          title: String.t() | nil
        }

  defstruct [
    :alliance_id,
    :birthday,
    :bloodline_id,
    :corporation_id,
    :description,
    :faction_id,
    :gender,
    :name,
    :race_id,
    :security_status,
    :title
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      birthday: {:string, :date_time},
      bloodline_id: :integer,
      corporation_id: :integer,
      description: {:string, :generic},
      faction_id: :integer,
      gender: {:enum, ["female", "male"]},
      name: {:string, :generic},
      race_id: :integer,
      security_status: :number,
      title: {:string, :generic}
    ]
  end
end
