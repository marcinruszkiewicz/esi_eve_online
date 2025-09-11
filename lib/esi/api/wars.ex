defmodule Esi.Api.Wars do
  @moduledoc """
  Provides API endpoints related to wars
  """

  @default_client Esi.Api.Client

  @doc """
  List kills for a war

  Return a list of kills related to a war

  ## Options

    * `page`

  """
  @spec killmails(integer, keyword) ::
          {:ok, [Esi.Api.WarsWarIdKillmailsGet.t()]} | {:error, Esi.Api.Error.t()}
  def killmails(war_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [war_id: war_id],
      call: {Esi.Api.Wars, :killmails},
      url: "/wars/#{war_id}/killmails",
      method: :get,
      query: query,
      response: [{200, [{Esi.Api.WarsWarIdKillmailsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List wars

  Return a list of wars

  ## Options

    * `max_war_id`

  """
  @spec wars(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def wars(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:max_war_id])

    client.request(%{
      args: [],
      call: {Esi.Api.Wars, :wars},
      url: "/wars",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get war information

  Return details about a war
  """
  @spec wars(integer, keyword) :: {:ok, Esi.Api.WarsWarIdGet.t()} | {:error, Esi.Api.Error.t()}
  def wars(war_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [war_id: war_id],
      call: {Esi.Api.Wars, :wars},
      url: "/wars/#{war_id}",
      method: :get,
      response: [{200, {Esi.Api.WarsWarIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
