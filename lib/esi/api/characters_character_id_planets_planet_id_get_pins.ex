defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPins do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetPins
  """

  @type t :: %__MODULE__{
          contents: [Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsContents.t()] | nil,
          expiry_time: DateTime.t() | nil,
          extractor_details:
            Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetails.t() | nil,
          factory_details:
            Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsFactoryDetails.t() | nil,
          install_time: DateTime.t() | nil,
          last_cycle_start: DateTime.t() | nil,
          latitude: number,
          longitude: number,
          pin_id: integer,
          schematic_id: integer | nil,
          type_id: integer
        }

  defstruct [
    :contents,
    :expiry_time,
    :extractor_details,
    :factory_details,
    :install_time,
    :last_cycle_start,
    :latitude,
    :longitude,
    :pin_id,
    :schematic_id,
    :type_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contents: [{Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsContents, :t}],
      expiry_time: {:string, :date_time},
      extractor_details:
        {Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetails, :t},
      factory_details: {Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsFactoryDetails, :t},
      install_time: {:string, :date_time},
      last_cycle_start: {:string, :date_time},
      latitude: :number,
      longitude: :number,
      pin_id: :integer,
      schematic_id: :integer,
      type_id: :integer
    ]
  end
end
