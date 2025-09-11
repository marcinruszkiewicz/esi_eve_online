defmodule Esi.Api.Meta do
  @moduledoc """
  Provides API endpoints related to meta
  """

  @default_client Esi.Client

  @doc """
  Get changelog

  Get the changelog of this API.
  """
  @spec get_changelog(keyword) :: {:ok, Esi.Api.MetaChangelog.t()} | {:error, Esi.Api.Error.t()}
  def get_changelog(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Meta, :get_changelog},
      url: "/meta/changelog",
      method: :get,
      response: [{200, {Esi.Api.MetaChangelog, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get compatibility dates

  Get a list of compatibility dates.
  """
  @spec get_compatibility_dates(keyword) ::
          {:ok, Esi.Api.MetaCompatibilityDates.t()} | {:error, Esi.Api.Error.t()}
  def get_compatibility_dates(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Meta, :get_compatibility_dates},
      url: "/meta/compatibility-dates",
      method: :get,
      response: [{200, {Esi.Api.MetaCompatibilityDates, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
