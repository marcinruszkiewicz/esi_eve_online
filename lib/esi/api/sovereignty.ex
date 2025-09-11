defmodule Esi.Api.Sovereignty do
  @moduledoc """
  Provides API endpoints related to sovereignty
  """

  @default_client Esi.Client

  @doc """
  List sovereignty campaigns

  Shows sovereignty data for campaigns.
  """
  @spec get_campaigns(keyword) ::
          {:ok, [Esi.Api.SovereigntyCampaignsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_campaigns(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Sovereignty, :get_campaigns},
      url: "/sovereignty/campaigns",
      method: :get,
      response: [{200, [{Esi.Api.SovereigntyCampaignsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List sovereignty of systems

  Shows sovereignty information for solar systems
  """
  @spec get_map(keyword) :: {:ok, [Esi.Api.SovereigntyMapGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_map(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Sovereignty, :get_map},
      url: "/sovereignty/map",
      method: :get,
      response: [{200, [{Esi.Api.SovereigntyMapGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List sovereignty structures

  Shows sovereignty data for structures.
  """
  @spec get_structures(keyword) ::
          {:ok, [Esi.Api.SovereigntyStructuresGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_structures(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Sovereignty, :get_structures},
      url: "/sovereignty/structures",
      method: :get,
      response: [{200, [{Esi.Api.SovereigntyStructuresGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
