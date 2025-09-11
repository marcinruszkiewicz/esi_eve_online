defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGet
  """

  @type t :: %__MODULE__{
          links: [Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetLinks.t()],
          pins: [Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPins.t()],
          routes: [Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetRoutes.t()]
        }

  defstruct [:links, :pins, :routes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      links: [{Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetLinks, :t}],
      pins: [{Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPins, :t}],
      routes: [{Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetRoutes, :t}]
    ]
  end
end
