defmodule Esi.Api.Contacts do
  @moduledoc """
  Provides API endpoints related to contacts
  """

  @default_client Esi.Api.Client

  @doc """
  Get contacts

  Return contacts of a character

  ## Options

    * `page`

  """
  @spec contacts(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContactsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contacts(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Contacts, :contacts},
      url: "/characters/#{character_id}/contacts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContactsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Edit contacts

  Bulk edit contacts with same settings

  ## Options

    * `label_ids`
    * `standing`
    * `watched`

  """
  @spec contacts(integer, [integer], keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def contacts(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:label_ids, :standing, :watched])

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Contacts, :contacts},
      url: "/characters/#{character_id}/contacts",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", [:integer]}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Add contacts

  Bulk add contacts with same settings

  ## Options

    * `label_ids`
    * `standing`
    * `watched`

  """
  @spec contacts(integer, [integer], keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def contacts(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:label_ids, :standing, :watched])

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Contacts, :contacts},
      url: "/characters/#{character_id}/contacts",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", [:integer]}],
      response: [{201, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete contacts

  Bulk delete contacts

  ## Options

    * `contact_ids`

  """
  @spec contacts(integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def contacts(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:contact_ids])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Contacts, :contacts},
      url: "/characters/#{character_id}/contacts",
      method: :delete,
      query: query,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get alliance contacts

  Return contacts of an alliance

  ## Options

    * `page`

  """
  @spec contacts(integer, keyword) ::
          {:ok, [Esi.Api.AlliancesAllianceIdContactsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contacts(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Contacts, :contacts},
      url: "/alliances/#{alliance_id}/contacts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.AlliancesAllianceIdContactsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation contacts

  Return contacts of a corporation

  ## Options

    * `page`

  """
  @spec contacts(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContactsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contacts(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Contacts, :contacts},
      url: "/corporations/#{corporation_id}/contacts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContactsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation contact labels

  Return custom labels for a corporation's contacts
  """
  @spec labels(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContactsLabelsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def labels(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Contacts, :labels},
      url: "/corporations/#{corporation_id}/contacts/labels",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContactsLabelsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get alliance contact labels

  Return custom labels for an alliance's contacts
  """
  @spec labels(integer, keyword) ::
          {:ok, [Esi.Api.AlliancesAllianceIdContactsLabelsGet.t()]} | {:error, Esi.Api.Error.t()}
  def labels(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Contacts, :labels},
      url: "/alliances/#{alliance_id}/contacts/labels",
      method: :get,
      response: [
        {200, [{Esi.Api.AlliancesAllianceIdContactsLabelsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get contact labels

  Return custom labels for a character's contacts
  """
  @spec labels(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContactsLabelsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def labels(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Contacts, :labels},
      url: "/characters/#{character_id}/contacts/labels",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContactsLabelsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
