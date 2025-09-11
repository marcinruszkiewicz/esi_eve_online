defmodule Esi.Api.Wallet do
  @moduledoc """
  Provides API endpoints related to wallet
  """

  @default_client Esi.Api.Client

  @doc """
  Get character wallet journal

  Retrieve the given character's wallet journal going 30 days back

  ## Options

    * `page`

  """
  @spec journal(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdWalletJournalGet.t()]} | {:error, Esi.Api.Error.t()}
  def journal(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Wallet, :journal},
      url: "/characters/#{character_id}/wallet/journal",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdWalletJournalGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation wallet journal

  Retrieve the given corporation's wallet journal for the given division going 30 days back

  ## Options

    * `page`

  """
  @spec journal(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdWalletsDivisionJournalGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def journal(corporation_id, division, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id, division: division],
      call: {Esi.Api.Wallet, :journal},
      url: "/corporations/#{corporation_id}/wallets/#{division}/journal",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdWalletsDivisionJournalGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get wallet transactions

  Get wallet transactions of a character

  ## Options

    * `from_id`

  """
  @spec transactions(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdWalletTransactionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def transactions(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:from_id])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Wallet, :transactions},
      url: "/characters/#{character_id}/wallet/transactions",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdWalletTransactionsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation wallet transactions

  Get wallet transactions of a corporation

  ## Options

    * `from_id`

  """
  @spec transactions(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdWalletsDivisionTransactionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def transactions(corporation_id, division, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:from_id])

    client.request(%{
      args: [corporation_id: corporation_id, division: division],
      call: {Esi.Api.Wallet, :transactions},
      url: "/corporations/#{corporation_id}/wallets/#{division}/transactions",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdWalletsDivisionTransactionsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get a character's wallet balance

  Returns a character's wallet balance
  """
  @spec wallet(integer, keyword) :: {:ok, number} | {:error, Esi.Api.Error.t()}
  def wallet(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Wallet, :wallet},
      url: "/characters/#{character_id}/wallet",
      method: :get,
      response: [{200, :number}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Returns a corporation's wallet balance

  Get a corporation's wallets
  """
  @spec wallets(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdWalletsGet.t()]} | {:error, Esi.Api.Error.t()}
  def wallets(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Wallet, :wallets},
      url: "/corporations/#{corporation_id}/wallets",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdWalletsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
