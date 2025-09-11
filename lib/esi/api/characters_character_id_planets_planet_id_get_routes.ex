defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetRoutes do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetRoutes
  """

  @type t :: %__MODULE__{
          content_type_id: integer,
          destination_pin_id: integer,
          quantity: number,
          route_id: integer,
          source_pin_id: integer,
          waypoints: [integer] | nil
        }

  defstruct [
    :content_type_id,
    :destination_pin_id,
    :quantity,
    :route_id,
    :source_pin_id,
    :waypoints
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content_type_id: :integer,
      destination_pin_id: :integer,
      quantity: :number,
      route_id: :integer,
      source_pin_id: :integer,
      waypoints: [:integer]
    ]
  end
end
