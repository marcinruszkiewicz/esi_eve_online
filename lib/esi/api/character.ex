defmodule Esi.Api.Character do
  @moduledoc """
  Provides API endpoints related to character
  """

  @default_client Esi.Api.Client

  @doc """
  Character affiliation

  Bulk lookup of character IDs to corporation, alliance and faction
  """
  @spec affiliation([integer], keyword) ::
          {:ok, [Esi.Api.CharactersAffiliationPost.t()]} | {:error, Esi.Api.Error.t()}
  def affiliation(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Esi.Api.Character, :affiliation},
      url: "/characters/affiliation",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [{200, [{Esi.Api.CharactersAffiliationPost, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get agents research

  Return a list of agents research information for a character. The formula for finding the current research points with an agent is: currentPoints = remainderPoints + pointsPerDay * days(currentTime - researchStartDate)
  """
  @spec agents_research(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdAgentsResearchGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def agents_research(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :agents_research},
      url: "/characters/#{character_id}/agents_research",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdAgentsResearchGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get blueprints

  Return a list of blueprints the character owns

  ## Options

    * `page`

  """
  @spec blueprints(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdBlueprintsGet.t()]} | {:error, Esi.Api.Error.t()}
  def blueprints(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :blueprints},
      url: "/characters/#{character_id}/blueprints",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdBlueprintsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character's public information

  Public information about a character
  """
  @spec characters(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdGet.t()} | {:error, Esi.Api.Error.t()}
  def characters(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :characters},
      url: "/characters/#{character_id}",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get new contact notifications

  Return notifications about having been added to someone's contact list
  """
  @spec contacts(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdNotificationsContactsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contacts(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :contacts},
      url: "/characters/#{character_id}/notifications/contacts",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdNotificationsContactsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation history

  Get a list of all the corporations a character has been a member of
  """
  @spec corporationhistory(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdCorporationhistoryGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def corporationhistory(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :corporationhistory},
      url: "/characters/#{character_id}/corporationhistory",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdCorporationhistoryGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Calculate a CSPA charge cost

  Takes a source character ID in the url and a set of target character ID's in the body, returns a CSPA charge cost
  """
  @spec cspa(integer, [integer], keyword) :: {:ok, number} | {:error, Esi.Api.Error.t()}
  def cspa(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Character, :cspa},
      url: "/characters/#{character_id}/cspa",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [{201, :number}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get jump fatigue

  Return a character's jump activation and fatigue information
  """
  @spec fatigue(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdFatigueGet.t()} | {:error, Esi.Api.Error.t()}
  def fatigue(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :fatigue},
      url: "/characters/#{character_id}/fatigue",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdFatigueGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get medals

  Return a list of medals the character has
  """
  @spec medals(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdMedalsGet.t()]} | {:error, Esi.Api.Error.t()}
  def medals(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :medals},
      url: "/characters/#{character_id}/medals",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdMedalsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character notifications

  Return character notifications
  """
  @spec notifications(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdNotificationsGet.t()]} | {:error, Esi.Api.Error.t()}
  def notifications(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :notifications},
      url: "/characters/#{character_id}/notifications",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdNotificationsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character portraits

  Get portrait urls for a character

  This route expires daily at 11:05
  """
  @spec portrait(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdPortraitGet.t()} | {:error, Esi.Api.Error.t()}
  def portrait(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :portrait},
      url: "/characters/#{character_id}/portrait",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdPortraitGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character corporation roles

  Returns a character's corporation roles
  """
  @spec roles(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdRolesGet.t()} | {:error, Esi.Api.Error.t()}
  def roles(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :roles},
      url: "/characters/#{character_id}/roles",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdRolesGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get standings

  Return character standings from agents, NPC corporations, and factions
  """
  @spec standings(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdStandingsGet.t()]} | {:error, Esi.Api.Error.t()}
  def standings(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :standings},
      url: "/characters/#{character_id}/standings",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdStandingsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character corporation titles

  Returns a character's titles
  """
  @spec titles(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdTitlesGet.t()]} | {:error, Esi.Api.Error.t()}
  def titles(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Character, :titles},
      url: "/characters/#{character_id}/titles",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdTitlesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
