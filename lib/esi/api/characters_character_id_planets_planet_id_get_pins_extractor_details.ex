defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetails do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetails
  """

  @type t :: %__MODULE__{
          cycle_time: integer | nil,
          head_radius: number | nil,
          heads: [Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetailsHeads.t()],
          product_type_id: integer | nil,
          qty_per_cycle: integer | nil
        }

  defstruct [:cycle_time, :head_radius, :heads, :product_type_id, :qty_per_cycle]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cycle_time: :integer,
      head_radius: :number,
      heads: [{Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetailsHeads, :t}],
      product_type_id: :integer,
      qty_per_cycle: :integer
    ]
  end
end
