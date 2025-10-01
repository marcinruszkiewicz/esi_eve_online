defmodule Esi.Api.Markets do
  @moduledoc """
  Provides API endpoints related to markets
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
      call: {Esi.Api.Markets, :group},
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
      call: {Esi.Api.Markets, :groups},
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
      call: {Esi.Api.Markets, :history},
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
    * `type_id`

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec orders(integer, keyword) :: Enumerable.t()
  def orders(region_id, opts \\ []) do
    query_opts = Keyword.take(opts, [:order_type, :type_id])
    all_opts = Keyword.merge(query_opts, opts)
    EsiEveOnline.stream_paginated("/markets/#{region_id}/orders", all_opts)
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
      call: {Esi.Api.Markets, :prices},
      url: "/markets/prices",
      method: :get,
      response: [{200, [{Esi.Api.MarketsPricesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List orders in a structure

  Return all orders in a structure

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec structure(integer, keyword) :: Enumerable.t()
  def structure(structure_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/markets/structures/#{structure_id}", opts)
  end

  @doc """
  List type IDs relevant to a market

  Return a list of type IDs that have active orders in the region, for efficient market indexing.

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec types(integer, keyword) :: Enumerable.t()
  def types(region_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/markets/#{region_id}/types", opts)
  end
end
