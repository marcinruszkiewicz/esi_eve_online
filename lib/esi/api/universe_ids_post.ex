defmodule Esi.Api.UniverseIdsPost do
  @moduledoc """
  Provides struct and type for a UniverseIdsPost
  """

  @type t :: %__MODULE__{
          agents: [Esi.Api.UniverseIdsPostAgents.t()] | nil,
          alliances: [Esi.Api.UniverseIdsPostAlliances.t()] | nil,
          characters: [Esi.Api.UniverseIdsPostCharacters.t()] | nil,
          constellations: [Esi.Api.UniverseIdsPostConstellations.t()] | nil,
          corporations: [Esi.Api.UniverseIdsPostCorporations.t()] | nil,
          factions: [Esi.Api.UniverseIdsPostFactions.t()] | nil,
          inventory_types: [Esi.Api.UniverseIdsPostInventoryTypes.t()] | nil,
          regions: [Esi.Api.UniverseIdsPostRegions.t()] | nil,
          stations: [Esi.Api.UniverseIdsPostStations.t()] | nil,
          systems: [Esi.Api.UniverseIdsPostSystems.t()] | nil
        }

  defstruct [
    :agents,
    :alliances,
    :characters,
    :constellations,
    :corporations,
    :factions,
    :inventory_types,
    :regions,
    :stations,
    :systems
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agents: [{Esi.Api.UniverseIdsPostAgents, :t}],
      alliances: [{Esi.Api.UniverseIdsPostAlliances, :t}],
      characters: [{Esi.Api.UniverseIdsPostCharacters, :t}],
      constellations: [{Esi.Api.UniverseIdsPostConstellations, :t}],
      corporations: [{Esi.Api.UniverseIdsPostCorporations, :t}],
      factions: [{Esi.Api.UniverseIdsPostFactions, :t}],
      inventory_types: [{Esi.Api.UniverseIdsPostInventoryTypes, :t}],
      regions: [{Esi.Api.UniverseIdsPostRegions, :t}],
      stations: [{Esi.Api.UniverseIdsPostStations, :t}],
      systems: [{Esi.Api.UniverseIdsPostSystems, :t}]
    ]
  end
end
