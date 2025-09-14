defmodule Esi.Api.Market do
  @moduledoc """
  Provides API endpoints related to market
  """

  @default_client Esi.Client

  @doc """
  Get item group information

  Get information on an item group

  This route expires daily at 11:05
  """
  @spec group(integer, keyword) ::
          {:ok, Esi.Api.MarketsGroupsMarketGroupIdGet.t()} | {:error, Esi.Api.Error.t()}
  def group(market_group_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [market_group_id: market_group_id],
      call: {Esi.Api.Market, :group},
      url: "/markets/groups/#{market_group_id}",
      method: :get,
      response: [{200, {Esi.Api.MarketsGroupsMarketGroupIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get item groups

  Get a list of item groups

  This route expires daily at 11:05
  """
  @spec groups(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def groups(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Market, :groups},
      url: "/markets/groups",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List historical market statistics in a region

  Return a list of historical market statistics for the specified type in a region

  This route expires daily at 11:05

  ## Options

    * `type_id`

  """
  @spec history(integer, keyword) ::
          {:ok, [Esi.Api.MarketsRegionIdHistoryGet.t()]} | {:error, Esi.Api.Error.t()}
  def history(region_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:type_id])

    client.request(%{
      args: [region_id: region_id],
      call: {Esi.Api.Market, :history},
      url: "/markets/#{region_id}/history",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.MarketsRegionIdHistoryGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List orders in a region

  Return a list of orders in a region

  ## Options

    * `order_type`
    * `page`
    * `type_id`

  """
  @spec orders(integer, keyword) ::
          {:ok, [Esi.Api.MarketsRegionIdOrdersGet.t()]} | {:error, Esi.Api.Error.t()}
  def orders(region_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order_type, :page, :type_id])

    client.request(%{
      args: [region_id: region_id],
      call: {Esi.Api.Market, :orders},
      url: "/markets/#{region_id}/orders",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.MarketsRegionIdOrdersGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List market prices

  Return a list of prices
  """
  @spec prices(keyword) :: {:ok, [Esi.Api.MarketsPricesGet.t()]} | {:error, Esi.Api.Error.t()}
  def prices(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Market, :prices},
      url: "/markets/prices",
      method: :get,
      response: [{200, [{Esi.Api.MarketsPricesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List orders in a structure

  Return all orders in a structure

  ## Options

    * `page`

  """
  @spec structure(integer, keyword) ::
          {:ok, [Esi.Api.MarketsStructuresStructureIdGet.t()]} | {:error, Esi.Api.Error.t()}
  def structure(structure_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [structure_id: structure_id],
      call: {Esi.Api.Market, :structure},
      url: "/markets/structures/#{structure_id}",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.MarketsStructuresStructureIdGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List type IDs relevant to a market

  Return a list of type IDs that have active orders in the region, for efficient market indexing.

  ## Options

    * `page`

  """
  @spec types(integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def types(region_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [region_id: region_id],
      call: {Esi.Api.Market, :types},
      url: "/markets/#{region_id}/types",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
