defmodule Esi.Api.Search do
  @moduledoc """
  Provides API endpoint related to search
  """

  @default_client Esi.Api.Client

  @doc """
  Search on a string

  Search for entities that match a given sub-string.

  ## Options

    * `categories`
    * `search`
    * `strict`

  """
  @spec search(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdSearchGet.t()} | {:error, Esi.Api.Error.t()}
  def search(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:categories, :search, :strict])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Search, :search},
      url: "/characters/#{character_id}/search",
      method: :get,
      query: query,
      response: [
        {200, {Esi.Api.CharactersCharacterIdSearchGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
