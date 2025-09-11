defmodule Esi.Api.UniverseConstellationsConstellationIdGet do
  @moduledoc """
  Provides struct and type for a UniverseConstellationsConstellationIdGet
  """

  @type t :: %__MODULE__{
          constellation_id: integer,
          name: String.t(),
          position: Esi.Api.UniverseConstellationsConstellationIdGetPosition.t(),
          region_id: integer,
          systems: [integer]
        }

  defstruct [:constellation_id, :name, :position, :region_id, :systems]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      constellation_id: :integer,
      name: {:string, :generic},
      position: {Esi.Api.UniverseConstellationsConstellationIdGetPosition, :t},
      region_id: :integer,
      systems: [:integer]
    ]
  end
end
