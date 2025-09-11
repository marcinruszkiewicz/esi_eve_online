defmodule Esi.Api.UniverseBloodlinesGet do
  @moduledoc """
  Provides struct and type for a UniverseBloodlinesGet
  """

  @type t :: %__MODULE__{
          bloodline_id: integer,
          charisma: integer,
          corporation_id: integer,
          description: String.t(),
          intelligence: integer,
          memory: integer,
          name: String.t(),
          perception: integer,
          race_id: integer,
          ship_type_id: integer,
          willpower: integer
        }

  defstruct [
    :bloodline_id,
    :charisma,
    :corporation_id,
    :description,
    :intelligence,
    :memory,
    :name,
    :perception,
    :race_id,
    :ship_type_id,
    :willpower
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bloodline_id: :integer,
      charisma: :integer,
      corporation_id: :integer,
      description: {:string, :generic},
      intelligence: :integer,
      memory: :integer,
      name: {:string, :generic},
      perception: :integer,
      race_id: :integer,
      ship_type_id: :integer,
      willpower: :integer
    ]
  end
end
