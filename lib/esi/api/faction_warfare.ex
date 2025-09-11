defmodule Esi.Api.FactionWarfare do
  @moduledoc """
  Provides API endpoints related to faction warfare
  """

  @default_client Esi.Api.Client

  @doc """
  List of the top pilots in faction warfare

  Top 100 leaderboard of pilots for kills and victory points separated by total, last week and yesterday

  This route expires daily at 11:05
  """
  @spec characters(keyword) ::
          {:ok, Esi.Api.FwLeaderboardsCharactersGet.t()} | {:error, Esi.Api.Error.t()}
  def characters(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.FactionWarfare, :characters},
      url: "/fw/leaderboards/characters",
      method: :get,
      response: [{200, {Esi.Api.FwLeaderboardsCharactersGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List of the top corporations in faction warfare

  Top 10 leaderboard of corporations for kills and victory points separated by total, last week and yesterday

  This route expires daily at 11:05
  """
  @spec corporations(keyword) ::
          {:ok, Esi.Api.FwLeaderboardsCorporationsGet.t()} | {:error, Esi.Api.Error.t()}
  def corporations(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.FactionWarfare, :corporations},
      url: "/fw/leaderboards/corporations",
      method: :get,
      response: [{200, {Esi.Api.FwLeaderboardsCorporationsGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List of the top factions in faction warfare

  Top 4 leaderboard of factions for kills and victory points separated by total, last week and yesterday

  This route expires daily at 11:05
  """
  @spec leaderboards(keyword) ::
          {:ok, Esi.Api.FwLeaderboardsGet.t()} | {:error, Esi.Api.Error.t()}
  def leaderboards(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.FactionWarfare, :leaderboards},
      url: "/fw/leaderboards",
      method: :get,
      response: [{200, {Esi.Api.FwLeaderboardsGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Overview of a character involved in faction warfare

  Statistical overview of a character involved in faction warfare

  This route expires daily at 11:05
  """
  @spec stats(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdFwStatsGet.t()} | {:error, Esi.Api.Error.t()}
  def stats(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.FactionWarfare, :stats},
      url: "/characters/#{character_id}/fw/stats",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdFwStatsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  An overview of statistics about factions involved in faction warfare

  Statistical overviews of factions involved in faction warfare

  This route expires daily at 11:05
  """
  @spec stats(keyword) :: {:ok, [Esi.Api.FwStatsGet.t()]} | {:error, Esi.Api.Error.t()}
  def stats(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.FactionWarfare, :stats},
      url: "/fw/stats",
      method: :get,
      response: [{200, [{Esi.Api.FwStatsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Overview of a corporation involved in faction warfare

  Statistics about a corporation involved in faction warfare

  This route expires daily at 11:05
  """
  @spec stats(integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdFwStatsGet.t()} | {:error, Esi.Api.Error.t()}
  def stats(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.FactionWarfare, :stats},
      url: "/corporations/#{corporation_id}/fw/stats",
      method: :get,
      response: [
        {200, {Esi.Api.CorporationsCorporationIdFwStatsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Ownership of faction warfare systems

  An overview of the current ownership of faction warfare solar systems
  """
  @spec systems(keyword) :: {:ok, [Esi.Api.FwSystemsGet.t()]} | {:error, Esi.Api.Error.t()}
  def systems(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.FactionWarfare, :systems},
      url: "/fw/systems",
      method: :get,
      response: [{200, [{Esi.Api.FwSystemsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Data about which NPC factions are at war

  Data about which NPC factions are at war

  This route expires daily at 11:05
  """
  @spec wars(keyword) :: {:ok, [Esi.Api.FwWarsGet.t()]} | {:error, Esi.Api.Error.t()}
  def wars(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.FactionWarfare, :wars},
      url: "/fw/wars",
      method: :get,
      response: [{200, [{Esi.Api.FwWarsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
