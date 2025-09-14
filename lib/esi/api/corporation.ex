defmodule Esi.Api.Corporation do
  @moduledoc """
  Provides API endpoints related to corporation
  """

  @default_client Esi.Client

  @doc """
  Moon extraction timers

  Extraction timers for all moon chunks being extracted by refineries belonging to a corporation.

  ## Options

    * `page`

  """
  @spec mining_extractions(integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningExtractionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def mining_extractions(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :mining_extractions},
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
  Observed corporation mining

  Paginated record of all mining seen by an observer

  ## Options

    * `page`

  """
  @spec mining_observer(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningObserversObserverIdGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def mining_observer(corporation_id, observer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id, observer_id: observer_id],
      call: {Esi.Api.Corporation, :mining_observer},
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
  Corporation mining observers

  Paginated list of all entities capable of observing and recording mining for a corporation

  ## Options

    * `page`

  """
  @spec mining_observers(integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningObserversGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def mining_observers(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :mining_observers},
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
end
