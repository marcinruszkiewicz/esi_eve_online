defmodule Esi.Api.Clones do
  @moduledoc """
  Provides API endpoints related to clones
  """

  @default_client Esi.Api.Client

  @doc """
  Get clones

  A list of the character's clones
  """
  @spec clones(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdClonesGet.t()} | {:error, Esi.Api.Error.t()}
  def clones(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Clones, :clones},
      url: "/characters/#{character_id}/clones",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdClonesGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get active implants

  Return implants on the active clone of a character
  """
  @spec implants(integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def implants(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Clones, :implants},
      url: "/characters/#{character_id}/implants",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
