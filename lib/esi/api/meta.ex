defmodule Esi.Api.Meta do
  @moduledoc """
  Provides API endpoints related to meta
  """

  @default_client Esi.Api.Client

  @doc """
  Get changelog

  Get the changelog of this API.
  """
  @spec changelog(keyword) :: {:ok, Esi.Api.MetaChangelog.t()} | {:error, Esi.Api.Error.t()}
  def changelog(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Meta, :changelog},
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
  @spec compatibility-dates(keyword) ::
          {:ok, Esi.Api.MetaCompatibilityDates.t()} | {:error, Esi.Api.Error.t()}
  def compatibility-dates(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Meta, :"compatibility-dates"},
      url: "/meta/compatibility-dates",
      method: :get,
      response: [{200, {Esi.Api.MetaCompatibilityDates, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
