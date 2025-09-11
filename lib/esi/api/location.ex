defmodule Esi.Api.Location do
  @moduledoc """
  Provides API endpoints related to location
  """

  @default_client Esi.Api.Client

  @doc """
  Get character location

  Information about the characters current location. Returns the current solar system id, and also the current station or structure ID if applicable
  """
  @spec location(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdLocationGet.t()} | {:error, Esi.Api.Error.t()}
  def location(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Location, :location},
      url: "/characters/#{character_id}/location",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdLocationGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character online

  Checks if the character is currently online
  """
  @spec online(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdOnlineGet.t()} | {:error, Esi.Api.Error.t()}
  def online(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Location, :online},
      url: "/characters/#{character_id}/online",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdOnlineGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get current ship

  Get the current ship type, name and id
  """
  @spec ship(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdShipGet.t()} | {:error, Esi.Api.Error.t()}
  def ship(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Location, :ship},
      url: "/characters/#{character_id}/ship",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdShipGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
