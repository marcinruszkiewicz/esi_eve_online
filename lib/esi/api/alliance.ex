defmodule Esi.Api.Alliance do
  @moduledoc """
  Provides API endpoints related to alliance
  """

  @default_client Esi.Client

  @doc """
  Get alliance contacts

  Return contacts of an alliance

  ## Options

    * `page`

  """
  @spec get_contacts(integer, keyword) ::
          {:ok, [Esi.Api.AlliancesAllianceIdContactsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_contacts(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :get_contacts},
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
  Get alliance contact labels

  Return custom labels for an alliance's contacts
  """
  @spec get_contacts_labels(integer, keyword) ::
          {:ok, [Esi.Api.AlliancesAllianceIdContactsLabelsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_contacts_labels(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :get_contacts_labels},
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
  List alliance's corporations

  List all current member corporations of an alliance
  """
  @spec get_corporations(integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_corporations(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :get_corporations},
      url: "/alliances/#{alliance_id}/corporations",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get alliance information

  Public information about an alliance
  """
  @spec get_get(integer, keyword) ::
          {:ok, Esi.Api.AlliancesAllianceIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :get_get},
      url: "/alliances/#{alliance_id}",
      method: :get,
      response: [{200, {Esi.Api.AlliancesAllianceIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get alliance icon

  Get the icon urls for a alliance

  This route expires daily at 11:05
  """
  @spec get_icons(integer, keyword) ::
          {:ok, Esi.Api.AlliancesAllianceIdIconsGet.t()} | {:error, Esi.Api.Error.t()}
  def get_icons(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :get_icons},
      url: "/alliances/#{alliance_id}/icons",
      method: :get,
      response: [{200, {Esi.Api.AlliancesAllianceIdIconsGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List all alliances

  List all active player alliances
  """
  @spec get_list(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_list(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Alliance, :get_list},
      url: "/alliances",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
