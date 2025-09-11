defmodule Esi.Api.Contracts do
  @moduledoc """
  Provides API endpoints related to contracts
  """

  @default_client Esi.Api.Client

  @doc """
  Get corporation contract bids

  Lists bids on a particular auction contract

  ## Options

    * `page`

  """
  @spec bids(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContractsContractIdBidsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def bids(contract_id, corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [contract_id: contract_id, corporation_id: corporation_id],
      call: {Esi.Api.Contracts, :bids},
      url: "/corporations/#{corporation_id}/contracts/#{contract_id}/bids",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContractsContractIdBidsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get contract bids

  Lists bids on a particular auction contract
  """
  @spec bids(integer, integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContractsContractIdBidsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def bids(character_id, contract_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, contract_id: contract_id],
      call: {Esi.Api.Contracts, :bids},
      url: "/characters/#{character_id}/contracts/#{contract_id}/bids",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContractsContractIdBidsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get public contract bids

  Lists bids on a public auction contract

  ## Options

    * `page`

  """
  @spec bids(integer, keyword) ::
          {:ok, map | [Esi.Api.ContractsPublicBidsContractIdGet.t()]} | :error
  def bids(contract_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [contract_id: contract_id],
      call: {Esi.Api.Contracts, :bids},
      url: "/contracts/public/bids/#{contract_id}",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.ContractsPublicBidsContractIdGet, :t}]}, {204, :map}],
      opts: opts
    })
  end

  @doc """
  Get contracts

  Returns contracts available to a character, only if the character is issuer, acceptor or assignee. Only returns contracts no older than 30 days, or if the status is "in_progress".

  ## Options

    * `page`

  """
  @spec contracts(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContractsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contracts(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Contracts, :contracts},
      url: "/characters/#{character_id}/contracts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContractsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation contracts

  Returns contracts available to a corporation, only if the corporation is issuer, acceptor or assignee. Only returns contracts no older than 30 days, or if the status is "in_progress".

  ## Options

    * `page`

  """
  @spec contracts(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContractsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contracts(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Contracts, :contracts},
      url: "/corporations/#{corporation_id}/contracts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContractsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get public contract items

  Lists items of a public contract

  ## Options

    * `page`

  """
  @spec items(integer, keyword) ::
          {:ok, map | [Esi.Api.ContractsPublicItemsContractIdGet.t()]} | :error
  def items(contract_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [contract_id: contract_id],
      call: {Esi.Api.Contracts, :items},
      url: "/contracts/public/items/#{contract_id}",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.ContractsPublicItemsContractIdGet, :t}]}, {204, :map}],
      opts: opts
    })
  end

  @doc """
  Get corporation contract items

  Lists items of a particular contract
  """
  @spec items(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContractsContractIdItemsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def items(contract_id, corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [contract_id: contract_id, corporation_id: corporation_id],
      call: {Esi.Api.Contracts, :items},
      url: "/corporations/#{corporation_id}/contracts/#{contract_id}/items",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContractsContractIdItemsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get contract items

  Lists items of a particular contract
  """
  @spec items(integer, integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContractsContractIdItemsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def items(character_id, contract_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, contract_id: contract_id],
      call: {Esi.Api.Contracts, :items},
      url: "/characters/#{character_id}/contracts/#{contract_id}/items",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContractsContractIdItemsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get public contracts

  Returns a paginated list of all public contracts in the given region

  ## Options

    * `page`

  """
  @spec public(integer, keyword) ::
          {:ok, [Esi.Api.ContractsPublicRegionIdGet.t()]} | {:error, Esi.Api.Error.t()}
  def public(region_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [region_id: region_id],
      call: {Esi.Api.Contracts, :public},
      url: "/contracts/public/#{region_id}",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.ContractsPublicRegionIdGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
