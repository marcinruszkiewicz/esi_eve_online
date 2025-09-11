defmodule Esi.Api.Assets do
  @moduledoc """
  Provides API endpoints related to assets
  """

  @default_client Esi.Api.Client

  @doc """
  Get character assets

  Return a list of the characters assets

  ## Options

    * `page`

  """
  @spec assets(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdAssetsGet.t()]} | {:error, Esi.Api.Error.t()}
  def assets(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Assets, :assets},
      url: "/characters/#{character_id}/assets",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdAssetsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation assets

  Return a list of the corporation assets

  ## Options

    * `page`

  """
  @spec assets(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAssetsGet.t()]} | {:error, Esi.Api.Error.t()}
  def assets(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Assets, :assets},
      url: "/corporations/#{corporation_id}/assets",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAssetsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation asset locations

  Return locations for a set of item ids, which you can get from corporation assets endpoint. Coordinates for items in hangars or stations are set to (0,0,0)
  """
  @spec locations(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAssetsLocationsPost.t()]}
          | {:error, Esi.Api.Error.t()}
  def locations(corporation_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, body: body],
      call: {Esi.Api.Assets, :locations},
      url: "/corporations/#{corporation_id}/assets/locations",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAssetsLocationsPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character asset locations

  Return locations for a set of item ids, which you can get from character assets endpoint. Coordinates for items in hangars or stations are set to (0,0,0)
  """
  @spec locations(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdAssetsLocationsPost.t()]}
          | {:error, Esi.Api.Error.t()}
  def locations(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Assets, :locations},
      url: "/characters/#{character_id}/assets/locations",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CharactersCharacterIdAssetsLocationsPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation asset names

  Return names for a set of item ids, which you can get from corporation assets endpoint. Only valid for items that can customize names, like containers or ships
  """
  @spec names(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAssetsNamesPost.t()]}
          | {:error, Esi.Api.Error.t()}
  def names(corporation_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, body: body],
      call: {Esi.Api.Assets, :names},
      url: "/corporations/#{corporation_id}/assets/names",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAssetsNamesPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character asset names

  Return names for a set of item ids, which you can get from character assets endpoint. Typically used for items that can customize names, like containers or ships.
  """
  @spec names(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdAssetsNamesPost.t()]} | {:error, Esi.Api.Error.t()}
  def names(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Assets, :names},
      url: "/characters/#{character_id}/assets/names",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CharactersCharacterIdAssetsNamesPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
