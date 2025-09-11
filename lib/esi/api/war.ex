defmodule Esi.Api.War do
  @moduledoc """
  Provides API endpoints related to war
  """

  @default_client Esi.Client

  @doc """
  Get war information

  Return details about a war
  """
  @spec get_get(integer, keyword) :: {:ok, Esi.Api.WarsWarIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get(war_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [war_id: war_id],
      call: {Esi.Api.War, :get_get},
      url: "/wars/#{war_id}",
      method: :get,
      response: [{200, {Esi.Api.WarsWarIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List kills for a war

  Return a list of kills related to a war

  ## Options

    * `page`

  """
  @spec get_killmails(integer, keyword) ::
          {:ok, [Esi.Api.WarsWarIdKillmailsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_killmails(war_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [war_id: war_id],
      call: {Esi.Api.War, :get_killmails},
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
  @spec get_list(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def get_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:max_war_id])

    client.request(%{
      args: [],
      call: {Esi.Api.War, :get_list},
      url: "/wars",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
