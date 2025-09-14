defmodule Esi.Api.Industry do
  @moduledoc """
  Provides API endpoints related to industry
  """

  @default_client Esi.Client

  @doc """
  List industry facilities

  Return a list of industry facilities
  """
  @spec facilities(keyword) ::
          {:ok, [Esi.Api.IndustryFacilitiesGet.t()]} | {:error, Esi.Api.Error.t()}
  def facilities(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Industry, :facilities},
      url: "/industry/facilities",
      method: :get,
      response: [{200, [{Esi.Api.IndustryFacilitiesGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List solar system cost indices

  Return cost indices for solar systems
  """
  @spec systems(keyword) :: {:ok, [Esi.Api.IndustrySystemsGet.t()]} | {:error, Esi.Api.Error.t()}
  def systems(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Industry, :systems},
      url: "/industry/systems",
      method: :get,
      response: [{200, [{Esi.Api.IndustrySystemsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
