defmodule Esi.Api.UniverseRegionsRegionIdGet do
  @moduledoc """
  Provides struct and type for a UniverseRegionsRegionIdGet
  """

  @type t :: %__MODULE__{
          constellations: [integer],
          description: String.t() | nil,
          name: String.t(),
          region_id: integer
        }

  defstruct [:constellations, :description, :name, :region_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      constellations: [:integer],
      description: {:string, :generic},
      name: {:string, :generic},
      region_id: :integer
    ]
  end
end
