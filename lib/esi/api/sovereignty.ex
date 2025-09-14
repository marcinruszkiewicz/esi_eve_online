defmodule Esi.Api.Sovereignty do
  @moduledoc """
  Provides API endpoints related to sovereignty
  """

  @default_client Esi.Client

  @doc """
  List sovereignty campaigns

  Shows sovereignty data for campaigns.
  """
  @spec campaigns(keyword) ::
          {:ok, [Esi.Api.SovereigntyCampaignsGet.t()]} | {:error, Esi.Api.Error.t()}
  def campaigns(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Sovereignty, :campaigns},
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
  @spec map(keyword) :: {:ok, [Esi.Api.SovereigntyMapGet.t()]} | {:error, Esi.Api.Error.t()}
  def map(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Sovereignty, :map},
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
  @spec structures(keyword) ::
          {:ok, [Esi.Api.SovereigntyStructuresGet.t()]} | {:error, Esi.Api.Error.t()}
  def structures(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Sovereignty, :structures},
      url: "/sovereignty/structures",
      method: :get,
      response: [{200, [{Esi.Api.SovereigntyStructuresGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
