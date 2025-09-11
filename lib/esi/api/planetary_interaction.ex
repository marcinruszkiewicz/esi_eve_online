defmodule Esi.Api.PlanetaryInteraction do
  @moduledoc """
  Provides API endpoints related to planetary interaction
  """

  @default_client Esi.Api.Client

  @doc """
  List corporation customs offices

  List customs offices owned by a corporation

  ## Options

    * `page`

  """
  @spec customs_offices(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdCustomsOfficesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def customs_offices(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.PlanetaryInteraction, :customs_offices},
      url: "/corporations/#{corporation_id}/customs_offices",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdCustomsOfficesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get colony layout

  Returns full details on the layout of a single planetary colony, including links, pins and routes. Note: Planetary information is only recalculated when the colony is viewed through the client. Information will not update until this criteria is met.
  """
  @spec planets(integer, integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdPlanetsPlanetIdGet.t()} | {:error, Esi.Api.Error.t()}
  def planets(character_id, planet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, planet_id: planet_id],
      call: {Esi.Api.PlanetaryInteraction, :planets},
      url: "/characters/#{character_id}/planets/#{planet_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdPlanetsPlanetIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get colonies

  Returns a list of all planetary colonies owned by a character.
  """
  @spec planets(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdPlanetsGet.t()]} | {:error, Esi.Api.Error.t()}
  def planets(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.PlanetaryInteraction, :planets},
      url: "/characters/#{character_id}/planets",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdPlanetsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get schematic information

  Get information on a planetary factory schematic
  """
  @spec schematics(integer, keyword) ::
          {:ok, Esi.Api.UniverseSchematicsSchematicIdGet.t()} | {:error, Esi.Api.Error.t()}
  def schematics(schematic_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schematic_id: schematic_id],
      call: {Esi.Api.PlanetaryInteraction, :schematics},
      url: "/universe/schematics/#{schematic_id}",
      method: :get,
      response: [
        {200, {Esi.Api.UniverseSchematicsSchematicIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
