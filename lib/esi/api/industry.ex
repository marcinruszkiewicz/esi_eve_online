defmodule Esi.Api.Industry do
  @moduledoc """
  Provides API endpoints related to industry
  """

  @default_client Esi.Api.Client

  @doc """
  Moon extraction timers

  Extraction timers for all moon chunks being extracted by refineries belonging to a corporation.

  ## Options

    * `page`

  """
  @spec extractions(integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningExtractionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def extractions(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Industry, :extractions},
      url: "/corporation/#{corporation_id}/mining/extractions",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationCorporationIdMiningExtractionsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List industry facilities

  Return a list of industry facilities
  """
  @spec facilities(keyword) ::
          {:ok, [Esi.Api.IndustryFacilitiesGet.t()]} | {:error, Esi.Api.Error.t()}
  def facilities(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Industry, :facilities},
      url: "/industry/facilities",
      method: :get,
      response: [{200, [{Esi.Api.IndustryFacilitiesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List character industry jobs

  List industry jobs placed by a character

  ## Options

    * `include_completed`

  """
  @spec jobs(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdIndustryJobsGet.t()]} | {:error, Esi.Api.Error.t()}
  def jobs(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include_completed])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Industry, :jobs},
      url: "/characters/#{character_id}/industry/jobs",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdIndustryJobsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List corporation industry jobs

  List industry jobs run by a corporation

  ## Options

    * `include_completed`
    * `page`

  """
  @spec jobs(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdIndustryJobsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def jobs(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include_completed, :page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Industry, :jobs},
      url: "/corporations/#{corporation_id}/industry/jobs",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdIndustryJobsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Character mining ledger

  Paginated record of all mining done by a character for the past 30 days

  ## Options

    * `page`

  """
  @spec mining(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdMiningGet.t()]} | {:error, Esi.Api.Error.t()}
  def mining(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Industry, :mining},
      url: "/characters/#{character_id}/mining",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdMiningGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Corporation mining observers

  Paginated list of all entities capable of observing and recording mining for a corporation

  ## Options

    * `page`

  """
  @spec observers(integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningObserversGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def observers(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Industry, :observers},
      url: "/corporation/#{corporation_id}/mining/observers",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationCorporationIdMiningObserversGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Observed corporation mining

  Paginated record of all mining seen by an observer

  ## Options

    * `page`

  """
  @spec observers(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningObserversObserverIdGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def observers(corporation_id, observer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id, observer_id: observer_id],
      call: {Esi.Api.Industry, :observers},
      url: "/corporation/#{corporation_id}/mining/observers/#{observer_id}",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationCorporationIdMiningObserversObserverIdGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List solar system cost indices

  Return cost indices for solar systems
  """
  @spec systems(keyword) :: {:ok, [Esi.Api.IndustrySystemsGet.t()]} | {:error, Esi.Api.Error.t()}
  def systems(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Industry, :systems},
      url: "/industry/systems",
      method: :get,
      response: [{200, [{Esi.Api.IndustrySystemsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
