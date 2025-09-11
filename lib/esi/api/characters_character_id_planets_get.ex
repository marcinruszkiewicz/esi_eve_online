defmodule Esi.Api.CharactersCharacterIdPlanetsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsGet
  """

  @type t :: %__MODULE__{
          last_update: DateTime.t(),
          num_pins: integer,
          owner_id: integer,
          planet_id: integer,
          planet_type: String.t(),
          solar_system_id: integer,
          upgrade_level: integer
        }

  defstruct [
    :last_update,
    :num_pins,
    :owner_id,
    :planet_id,
    :planet_type,
    :solar_system_id,
    :upgrade_level
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      last_update: {:string, :date_time},
      num_pins: :integer,
      owner_id: :integer,
      planet_id: :integer,
      planet_type:
        {:enum, ["temperate", "barren", "oceanic", "ice", "gas", "lava", "storm", "plasma"]},
      solar_system_id: :integer,
      upgrade_level: :integer
    ]
  end
end
