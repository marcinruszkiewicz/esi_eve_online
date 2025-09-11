defmodule Esi.Api.Alliance do
  @moduledoc """
  Provides API endpoints related to alliance
  """

  @default_client Esi.Api.Client

  @doc """
  List all alliances

  List all active player alliances
  """
  @spec alliances(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def alliances(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Alliance, :alliances},
      url: "/alliances",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get alliance information

  Public information about an alliance
  """
  @spec alliances(integer, keyword) ::
          {:ok, Esi.Api.AlliancesAllianceIdGet.t()} | {:error, Esi.Api.Error.t()}
  def alliances(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :alliances},
      url: "/alliances/#{alliance_id}",
      method: :get,
      response: [{200, {Esi.Api.AlliancesAllianceIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List alliance's corporations

  List all current member corporations of an alliance
  """
  @spec corporations(integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def corporations(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :corporations},
      url: "/alliances/#{alliance_id}/corporations",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get alliance icon

  Get the icon urls for a alliance

  This route expires daily at 11:05
  """
  @spec icons(integer, keyword) ::
          {:ok, Esi.Api.AlliancesAllianceIdIconsGet.t()} | {:error, Esi.Api.Error.t()}
  def icons(alliance_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [alliance_id: alliance_id],
      call: {Esi.Api.Alliance, :icons},
      url: "/alliances/#{alliance_id}/icons",
      method: :get,
      response: [{200, {Esi.Api.AlliancesAllianceIdIconsGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
