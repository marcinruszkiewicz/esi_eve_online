defmodule Esi.Api.Killmail do
  @moduledoc """
  Provides API endpoint related to killmail
  """

  @default_client Esi.Client

  @doc """
  Get a single killmail

  Return a single killmail from its ID and hash
  """
  @spec get_get(String.t(), integer, keyword) ::
          {:ok, Esi.Api.KillmailsKillmailIdKillmailHashGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get(killmail_hash, killmail_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [killmail_hash: killmail_hash, killmail_id: killmail_id],
      call: {Esi.Api.Killmail, :get_get},
      url: "/killmails/#{killmail_id}/#{killmail_hash}",
      method: :get,
      response: [
        {200, {Esi.Api.KillmailsKillmailIdKillmailHashGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
