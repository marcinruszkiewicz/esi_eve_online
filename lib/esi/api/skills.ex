defmodule Esi.Api.Skills do
  @moduledoc """
  Provides API endpoints related to skills
  """

  @default_client Esi.Api.Client

  @doc """
  Get character attributes

  Return attributes of a character
  """
  @spec attributes(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdAttributesGet.t()} | {:error, Esi.Api.Error.t()}
  def attributes(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Skills, :attributes},
      url: "/characters/#{character_id}/attributes",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdAttributesGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character's skill queue

  List the configured skill queue for the given character
  """
  @spec skillqueue(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdSkillqueueGet.t()]} | {:error, Esi.Api.Error.t()}
  def skillqueue(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Skills, :skillqueue},
      url: "/characters/#{character_id}/skillqueue",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdSkillqueueGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character skills

  List all trained skills for the given character
  """
  @spec skills(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdSkillsGet.t()} | {:error, Esi.Api.Error.t()}
  def skills(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Skills, :skills},
      url: "/characters/#{character_id}/skills",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdSkillsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
