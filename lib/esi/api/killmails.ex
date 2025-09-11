defmodule Esi.Api.Killmails do
  @moduledoc """
  Provides API endpoints related to killmails
  """

  @default_client Esi.Api.Client

  @doc """
  Get a single killmail

  Return a single killmail from its ID and hash
  """
  @spec killmails(String.t(), integer, keyword) ::
          {:ok, Esi.Api.KillmailsKillmailIdKillmailHashGet.t()} | {:error, Esi.Api.Error.t()}
  def killmails(killmail_hash, killmail_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [killmail_hash: killmail_hash, killmail_id: killmail_id],
      call: {Esi.Api.Killmails, :killmails},
      url: "/killmails/#{killmail_id}/#{killmail_hash}",
      method: :get,
      response: [
        {200, {Esi.Api.KillmailsKillmailIdKillmailHashGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get a character's recent kills and losses

  Return a list of a character's kills and losses going back 90 days

  ## Options

    * `page`

  """
  @spec recent(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdKillmailsRecentGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def recent(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Killmails, :recent},
      url: "/characters/#{character_id}/killmails/recent",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdKillmailsRecentGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get a corporation's recent kills and losses

  Get a list of a corporation's kills and losses going back 90 days

  ## Options

    * `page`

  """
  @spec recent(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdKillmailsRecentGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def recent(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Killmails, :recent},
      url: "/corporations/#{corporation_id}/killmails/recent",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdKillmailsRecentGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
