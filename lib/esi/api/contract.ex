defmodule Esi.Api.Contract do
  @moduledoc """
  Provides API endpoints related to contract
  """

  @default_client Esi.Client

  @doc """
  Get public contracts

  Returns a paginated list of all public contracts in the given region

  ## Options

    * `page`

  """
  @spec get_get_public(integer, keyword) ::
          {:ok, [Esi.Api.ContractsPublicRegionIdGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_get_public(region_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [region_id: region_id],
      call: {Esi.Api.Contract, :get_get_public},
      url: "/contracts/public/#{region_id}",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.ContractsPublicRegionIdGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get public contract bids

  Lists bids on a public auction contract

  ## Options

    * `page`

  """
  @spec get_get_public_bids(integer, keyword) ::
          {:ok, map | [Esi.Api.ContractsPublicBidsContractIdGet.t()]} | :error
  def get_get_public_bids(contract_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [contract_id: contract_id],
      call: {Esi.Api.Contract, :get_get_public_bids},
      url: "/contracts/public/bids/#{contract_id}",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.ContractsPublicBidsContractIdGet, :t}]}, {204, :map}],
      opts: opts
    })
  end

  @doc """
  Get public contract items

  Lists items of a public contract

  ## Options

    * `page`

  """
  @spec get_get_public_items(integer, keyword) ::
          {:ok, map | [Esi.Api.ContractsPublicItemsContractIdGet.t()]} | :error
  def get_get_public_items(contract_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [contract_id: contract_id],
      call: {Esi.Api.Contract, :get_get_public_items},
      url: "/contracts/public/items/#{contract_id}",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.ContractsPublicItemsContractIdGet, :t}]}, {204, :map}],
      opts: opts
    })
  end
end
