defmodule Esi.Api.Fittings do
  @moduledoc """
  Provides API endpoints related to fittings
  """

  @default_client Esi.Api.Client

  @doc """
  Get fittings

  Return fittings of a character
  """
  @spec fittings(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdFittingsGet.t()]} | {:error, Esi.Api.Error.t()}
  def fittings(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Fittings, :fittings},
      url: "/characters/#{character_id}/fittings",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdFittingsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Create fitting

  Save a new fitting for a character
  """
  @spec fittings(integer, map, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdFittingsPost.t()} | {:error, Esi.Api.Error.t()}
  def fittings(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Fittings, :fittings},
      url: "/characters/#{character_id}/fittings",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {Esi.Api.CharactersCharacterIdFittingsPost, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Delete fitting

  Delete a fitting from a character
  """
  @spec fittings(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def fittings(character_id, fitting_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, fitting_id: fitting_id],
      call: {Esi.Api.Fittings, :fittings},
      url: "/characters/#{character_id}/fittings/#{fitting_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
