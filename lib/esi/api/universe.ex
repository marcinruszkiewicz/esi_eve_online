defmodule Esi.Api.Universe do
  @moduledoc """
  Provides API endpoints related to universe
  """

  @default_client Esi.Client

  @doc """
  Get ancestries

  Get all character ancestries

  This route expires daily at 11:05
  """
  @spec get_ancestries(keyword) ::
          {:ok, [Esi.Api.UniverseAncestriesGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_ancestries(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_ancestries},
      url: "/universe/ancestries",
      method: :get,
      response: [{200, [{Esi.Api.UniverseAncestriesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get bloodlines

  Get a list of bloodlines

  This route expires daily at 11:05
  """
  @spec get_bloodlines(keyword) ::
          {:ok, [Esi.Api.UniverseBloodlinesGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_bloodlines(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_bloodlines},
      url: "/universe/bloodlines",
      method: :get,
      response: [{200, [{Esi.Api.UniverseBloodlinesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get item categories

  Get a list of item categories

  This route expires daily at 11:05
  """
  @spec get_categories(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_categories(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_categories},
      url: "/universe/categories",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get constellations

  Get a list of constellations

  This route expires daily at 11:05
  """
  @spec get_constellations(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_constellations(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_constellations},
      url: "/universe/constellations",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get factions

  Get a list of factions

  This route expires daily at 11:05
  """
  @spec get_factions(keyword) ::
          {:ok, [Esi.Api.UniverseFactionsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_factions(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_factions},
      url: "/universe/factions",
      method: :get,
      response: [{200, [{Esi.Api.UniverseFactionsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get asteroid belt information

  Get information on an asteroid belt

  This route expires daily at 11:05
  """
  @spec get_get_asteroid_belts(integer, keyword) ::
          {:ok, Esi.Api.UniverseAsteroidBeltsAsteroidBeltIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_asteroid_belts(asteroid_belt_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [asteroid_belt_id: asteroid_belt_id],
      call: {Esi.Api.Universe, :get_get_asteroid_belts},
      url: "/universe/asteroid_belts/#{asteroid_belt_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseAsteroidBeltsAsteroidBeltIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get item category information

  Get information of an item category

  This route expires daily at 11:05
  """
  @spec get_get_categories(integer, keyword) ::
          {:ok, Esi.Api.UniverseCategoriesCategoryIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_categories(category_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [category_id: category_id],
      call: {Esi.Api.Universe, :get_get_categories},
      url: "/universe/categories/#{category_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseCategoriesCategoryIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get constellation information

  Get information on a constellation

  This route expires daily at 11:05
  """
  @spec get_get_constellations(integer, keyword) ::
          {:ok, Esi.Api.UniverseConstellationsConstellationIdGet.t()}
          | {:error, Esi.Api.Error.t()}
  def get_get_constellations(constellation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [constellation_id: constellation_id],
      call: {Esi.Api.Universe, :get_get_constellations},
      url: "/universe/constellations/#{constellation_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseConstellationsConstellationIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get graphic information

  Get information on a graphic

  This route expires daily at 11:05
  """
  @spec get_get_graphics(integer, keyword) ::
          {:ok, Esi.Api.UniverseGraphicsGraphicIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_graphics(graphic_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [graphic_id: graphic_id],
      call: {Esi.Api.Universe, :get_get_graphics},
      url: "/universe/graphics/#{graphic_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseGraphicsGraphicIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get item group information

  Get information on an item group

  This route expires daily at 11:05
  """
  @spec get_get_groups(integer, keyword) ::
          {:ok, Esi.Api.UniverseGroupsGroupIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_groups(group_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [group_id: group_id],
      call: {Esi.Api.Universe, :get_get_groups},
      url: "/universe/groups/#{group_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseGroupsGroupIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get moon information

  Get information on a moon

  This route expires daily at 11:05
  """
  @spec get_get_moons(integer, keyword) ::
          {:ok, Esi.Api.UniverseMoonsMoonIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_moons(moon_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [moon_id: moon_id],
      call: {Esi.Api.Universe, :get_get_moons},
      url: "/universe/moons/#{moon_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseMoonsMoonIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get planet information

  Get information on a planet

  This route expires daily at 11:05
  """
  @spec get_get_planets(integer, keyword) ::
          {:ok, Esi.Api.UniversePlanetsPlanetIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_planets(planet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [planet_id: planet_id],
      call: {Esi.Api.Universe, :get_get_planets},
      url: "/universe/planets/#{planet_id}",
      method: :get,
      response: [{200, {Esi.Api.UniversePlanetsPlanetIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get region information

  Get information on a region

  This route expires daily at 11:05
  """
  @spec get_get_regions(integer, keyword) ::
          {:ok, Esi.Api.UniverseRegionsRegionIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_regions(region_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [region_id: region_id],
      call: {Esi.Api.Universe, :get_get_regions},
      url: "/universe/regions/#{region_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseRegionsRegionIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get schematic information

  Get information on a planetary factory schematic
  """
  @spec get_get_schematics(integer, keyword) ::
          {:ok, Esi.Api.UniverseSchematicsSchematicIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_schematics(schematic_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schematic_id: schematic_id],
      call: {Esi.Api.Universe, :get_get_schematics},
      url: "/universe/schematics/#{schematic_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseSchematicsSchematicIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get stargate information

  Get information on a stargate

  This route expires daily at 11:05
  """
  @spec get_get_stargates(integer, keyword) ::
          {:ok, Esi.Api.UniverseStargatesStargateIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_stargates(stargate_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [stargate_id: stargate_id],
      call: {Esi.Api.Universe, :get_get_stargates},
      url: "/universe/stargates/#{stargate_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseStargatesStargateIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get star information

  Get information on a star

  This route expires daily at 11:05
  """
  @spec get_get_stars(integer, keyword) ::
          {:ok, Esi.Api.UniverseStarsStarIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_stars(star_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [star_id: star_id],
      call: {Esi.Api.Universe, :get_get_stars},
      url: "/universe/stars/#{star_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseStarsStarIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get station information

  Get information on a station

  This route expires daily at 11:05
  """
  @spec get_get_stations(integer, keyword) ::
          {:ok, Esi.Api.UniverseStationsStationIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_stations(station_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [station_id: station_id],
      call: {Esi.Api.Universe, :get_get_stations},
      url: "/universe/stations/#{station_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseStationsStationIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get structure information

  Returns information on requested structure if you are on the ACL. Otherwise, returns "Forbidden" for all inputs.
  """
  @spec get_get_structures(integer, keyword) ::
          {:ok, Esi.Api.UniverseStructuresStructureIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_structures(structure_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [structure_id: structure_id],
      call: {Esi.Api.Universe, :get_get_structures},
      url: "/universe/structures/#{structure_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseStructuresStructureIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get solar system information

  Get information on a solar system.

  This route expires daily at 11:05
  """
  @spec get_get_systems(integer, keyword) ::
          {:ok, Esi.Api.UniverseSystemsSystemIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_systems(system_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [system_id: system_id],
      call: {Esi.Api.Universe, :get_get_systems},
      url: "/universe/systems/#{system_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseSystemsSystemIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get type information

  Get information on a type

  This route expires daily at 11:05
  """
  @spec get_get_types(integer, keyword) ::
          {:ok, Esi.Api.UniverseTypesTypeIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get_types(type_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [type_id: type_id],
      call: {Esi.Api.Universe, :get_get_types},
      url: "/universe/types/#{type_id}",
      method: :get,
      response: [{200, {Esi.Api.UniverseTypesTypeIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get graphics

  Get a list of graphics

  This route expires daily at 11:05
  """
  @spec get_graphics(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_graphics(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_graphics},
      url: "/universe/graphics",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get item groups

  Get a list of item groups

  This route expires daily at 11:05

  ## Options

    * `page`

  """
  @spec get_groups(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_groups(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_groups},
      url: "/universe/groups",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get character races

  Get a list of character races

  This route expires daily at 11:05
  """
  @spec get_races(keyword) :: {:ok, [Esi.Api.UniverseRacesGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_races(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_races},
      url: "/universe/races",
      method: :get,
      response: [{200, [{Esi.Api.UniverseRacesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get regions

  Get a list of regions

  This route expires daily at 11:05
  """
  @spec get_regions(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_regions(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_regions},
      url: "/universe/regions",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List all public structures

  List all public structures

  ## Options

    * `filter`

  """
  @spec get_structures(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_structures(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter])

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_structures},
      url: "/universe/structures",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get system jumps

  Get the number of jumps in solar systems within the last hour ending at the timestamp of the Last-Modified header, excluding wormhole space. Only systems with jumps will be listed
  """
  @spec get_system_jumps(keyword) ::
          {:ok, [Esi.Api.UniverseSystemJumpsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_system_jumps(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_system_jumps},
      url: "/universe/system_jumps",
      method: :get,
      response: [{200, [{Esi.Api.UniverseSystemJumpsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get system kills

  Get the number of ship, pod and NPC kills per solar system within the last hour ending at the timestamp of the Last-Modified header, excluding wormhole space. Only systems with kills will be listed
  """
  @spec get_system_kills(keyword) ::
          {:ok, [Esi.Api.UniverseSystemKillsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_system_kills(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_system_kills},
      url: "/universe/system_kills",
      method: :get,
      response: [{200, [{Esi.Api.UniverseSystemKillsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get solar systems

  Get a list of solar systems

  This route expires daily at 11:05
  """
  @spec get_systems(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_systems(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_systems},
      url: "/universe/systems",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get types

  Get a list of type ids

  This route expires daily at 11:05

  ## Options

    * `page`

  """
  @spec get_types(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_types(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [],
      call: {Esi.Api.Universe, :get_types},
      url: "/universe/types",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Bulk names to IDs

  Resolve a set of names to IDs in the following categories: agents, alliances, characters, constellations, corporations factions, inventory_types, regions, stations, and systems. Only exact matches will be returned. All names searched for are cached for 12 hours
  """
  @spec post_ids([String.t()], keyword) ::
          {:ok, Esi.Api.UniverseIdsPost.t()} | {:error, Esi.Api.Error.t()}
  def post_ids(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Esi.Api.Universe, :post_ids},
      url: "/universe/ids",
      body: body,
      method: :post,
      request: [{"application/json", [string: :generic]}],
      response: [{200, {Esi.Api.UniverseIdsPost, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get names and categories for a set of IDs

  Resolve a set of IDs to names and categories. Supported ID's for resolving are: Characters, Corporations, Alliances, Stations, Solar Systems, Constellations, Regions, Types, Factions
  """
  @spec post_names([integer], keyword) ::
          {:ok, [Esi.Api.UniverseNamesPost.t()]} | {:error, Esi.Api.Error.t()}
  def post_names(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Esi.Api.Universe, :post_names},
      url: "/universe/names",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [{200, [{Esi.Api.UniverseNamesPost, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
