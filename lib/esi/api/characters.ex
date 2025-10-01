defmodule Esi.Api.Characters do
  @moduledoc """
  Provides API endpoints related to characters
  """

  @default_client Esi.Client

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
      call: {Esi.Api.Characters, :affiliation},
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
      call: {Esi.Api.Characters, :agents_research},
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
  Get character assets

  Return a list of the characters assets

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec assets(integer, keyword) :: Enumerable.t()
  def assets(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/assets", opts)
  end

  @doc """
  Get character asset locations

  Return locations for a set of item ids, which you can get from character assets endpoint. Coordinates for items in hangars or stations are set to (0,0,0)
  """
  @spec assets_locations(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdAssetsLocationsPost.t()]}
          | {:error, Esi.Api.Error.t()}
  def assets_locations(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :assets_locations},
      url: "/characters/#{character_id}/assets/locations",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CharactersCharacterIdAssetsLocationsPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character asset names

  Return names for a set of item ids, which you can get from character assets endpoint. Typically used for items that can customize names, like containers or ships.
  """
  @spec assets_names(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdAssetsNamesPost.t()]} | {:error, Esi.Api.Error.t()}
  def assets_names(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :assets_names},
      url: "/characters/#{character_id}/assets/names",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CharactersCharacterIdAssetsNamesPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

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
      call: {Esi.Api.Characters, :attributes},
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
  Get blueprints

  Return a list of blueprints the character owns

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec blueprints(integer, keyword) :: Enumerable.t()
  def blueprints(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/blueprints", opts)
  end

  @doc """
  List calendar event summaries

  Get 50 event summaries from the calendar. If no from_event ID is given, the resource will return the next 50 chronological event summaries from now. If a from_event ID is specified, it will return the next 50 chronological event summaries from after that event

  ## Options

    * `from_event`

  """
  @spec calendar(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdCalendarGet.t()]} | {:error, Esi.Api.Error.t()}
  def calendar(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:from_event])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :calendar},
      url: "/characters/#{character_id}/calendar",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdCalendarGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get attendees

  Get all invited attendees for a given event
  """
  @spec calendar_attendees(integer, integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdCalendarEventIdAttendeesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def calendar_attendees(character_id, event_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, event_id: event_id],
      call: {Esi.Api.Characters, :calendar_attendees},
      url: "/characters/#{character_id}/calendar/#{event_id}/attendees",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdCalendarEventIdAttendeesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get an event

  Get all the information for a specific event
  """
  @spec calendar_item(integer, integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdCalendarEventIdGet.t()} | {:error, Esi.Api.Error.t()}
  def calendar_item(character_id, event_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, event_id: event_id],
      call: {Esi.Api.Characters, :calendar_item},
      url: "/characters/#{character_id}/calendar/#{event_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdCalendarEventIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get character's public information

  Public information about a character
  """
  @spec character(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdGet.t()} | {:error, Esi.Api.Error.t()}
  def character(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :character},
      url: "/characters/#{character_id}",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

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
      call: {Esi.Api.Characters, :clones},
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
  Get contacts

  Return contacts of a character

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec contacts(integer, keyword) :: Enumerable.t()
  def contacts(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/contacts", opts)
  end

  @doc """
  Get contact labels

  Return custom labels for a character's contacts
  """
  @spec contacts_labels(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContactsLabelsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contacts_labels(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :contacts_labels},
      url: "/characters/#{character_id}/contacts/labels",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContactsLabelsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get contracts

  Returns contracts available to a character, only if the character is issuer, acceptor or assignee. Only returns contracts no older than 30 days, or if the status is "in_progress".

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec contracts(integer, keyword) :: Enumerable.t()
  def contracts(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/contracts", opts)
  end

  @doc """
  Get contract bids

  Lists bids on a particular auction contract
  """
  @spec contracts_bids(integer, integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContractsContractIdBidsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contracts_bids(character_id, contract_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, contract_id: contract_id],
      call: {Esi.Api.Characters, :contracts_bids},
      url: "/characters/#{character_id}/contracts/#{contract_id}/bids",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContractsContractIdBidsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get contract items

  Lists items of a particular contract
  """
  @spec contracts_items(integer, integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdContractsContractIdItemsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contracts_items(character_id, contract_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, contract_id: contract_id],
      call: {Esi.Api.Characters, :contracts_items},
      url: "/characters/#{character_id}/contracts/#{contract_id}/items",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdContractsContractIdItemsGet, :t}]},
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
      call: {Esi.Api.Characters, :corporationhistory},
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
  Add contacts

  Bulk add contacts with same settings

  ## Options

    * `label_ids`
    * `standing`
    * `watched`

  """
  @spec create_contacts(integer, [integer], keyword) ::
          {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def create_contacts(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:label_ids, :standing, :watched])

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :create_contacts},
      url: "/characters/#{character_id}/contacts",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", [:integer]}],
      response: [{201, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Create fitting

  Save a new fitting for a character
  """
  @spec create_fittings(integer, map, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdFittingsPost.t()} | {:error, Esi.Api.Error.t()}
  def create_fittings(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :create_fittings},
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
  Send a new mail

  Create and send a new mail
  """
  @spec create_mail(integer, map, keyword) :: {:ok, integer} | {:error, Esi.Api.Error.t()}
  def create_mail(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :create_mail},
      url: "/characters/#{character_id}/mail",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, :integer}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Create a mail label

  Create a mail label
  """
  @spec create_mail_labels(integer, map, keyword) :: {:ok, integer} | {:error, Esi.Api.Error.t()}
  def create_mail_labels(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :create_mail_labels},
      url: "/characters/#{character_id}/mail/labels",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, :integer}, default: {Esi.Api.Error, :t}],
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
      call: {Esi.Api.Characters, :cspa},
      url: "/characters/#{character_id}/cspa",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [{201, :number}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete contacts

  Bulk delete contacts

  ## Options

    * `contact_ids`

  """
  @spec delete_contacts(integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_contacts(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:contact_ids])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :delete_contacts},
      url: "/characters/#{character_id}/contacts",
      method: :delete,
      query: query,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete fitting

  Delete a fitting from a character
  """
  @spec delete_fittings(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_fittings(character_id, fitting_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, fitting_id: fitting_id],
      call: {Esi.Api.Characters, :delete_fittings},
      url: "/characters/#{character_id}/fittings/#{fitting_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete a mail

  Delete a mail
  """
  @spec delete_mail(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_mail(character_id, mail_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, mail_id: mail_id],
      call: {Esi.Api.Characters, :delete_mail},
      url: "/characters/#{character_id}/mail/#{mail_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete a mail label

  Delete a mail label
  """
  @spec delete_mail_labels(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_mail_labels(character_id, label_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, label_id: label_id],
      call: {Esi.Api.Characters, :delete_mail_labels},
      url: "/characters/#{character_id}/mail/labels/#{label_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
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
      call: {Esi.Api.Characters, :fatigue},
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
  Get fittings

  Return fittings of a character
  """
  @spec fittings(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdFittingsGet.t()]} | {:error, Esi.Api.Error.t()}
  def fittings(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :fittings},
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
  Get character fleet info

  Return the fleet ID the character is in, if any.
  """
  @spec fleet(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdFleetGet.t()} | {:error, Esi.Api.Error.t()}
  def fleet(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :fleet},
      url: "/characters/#{character_id}/fleet",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdFleetGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Overview of a character involved in faction warfare

  Statistical overview of a character involved in faction warfare

  This route expires daily at 11:05
  """
  @spec fw_stats(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdFwStatsGet.t()} | {:error, Esi.Api.Error.t()}
  def fw_stats(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :fw_stats},
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
  Get active implants

  Return implants on the active clone of a character
  """
  @spec implants(integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def implants(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :implants},
      url: "/characters/#{character_id}/implants",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List character industry jobs

  List industry jobs placed by a character

  ## Options

    * `include_completed`

  """
  @spec industry_jobs(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdIndustryJobsGet.t()]} | {:error, Esi.Api.Error.t()}
  def industry_jobs(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include_completed])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :industry_jobs},
      url: "/characters/#{character_id}/industry/jobs",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdIndustryJobsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get a character's recent kills and losses

  Return a list of a character's kills and losses going back 90 days

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec killmails_recent(integer, keyword) :: Enumerable.t()
  def killmails_recent(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/killmails/recent", opts)
  end

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
      call: {Esi.Api.Characters, :location},
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
  Get loyalty points

  Return a list of loyalty points for all corporations the character has worked for
  """
  @spec loyalty_points(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdLoyaltyPointsGet.t()]} | {:error, Esi.Api.Error.t()}
  def loyalty_points(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :loyalty_points},
      url: "/characters/#{character_id}/loyalty/points",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdLoyaltyPointsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Return mail headers

  Return the 50 most recent mail headers belonging to the character that match the query criteria. Queries can be filtered by label, and last_mail_id can be used to paginate backwards

  ## Options

    * `labels`
    * `last_mail_id`

  """
  @spec mail(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdMailGet.t()]} | {:error, Esi.Api.Error.t()}
  def mail(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:labels, :last_mail_id])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :mail},
      url: "/characters/#{character_id}/mail",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdMailGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Return a mail

  Return the contents of an EVE mail
  """
  @spec mail_item(integer, integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdMailMailIdGet.t()} | {:error, Esi.Api.Error.t()}
  def mail_item(character_id, mail_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, mail_id: mail_id],
      call: {Esi.Api.Characters, :mail_item},
      url: "/characters/#{character_id}/mail/#{mail_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdMailMailIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get mail labels and unread counts

  Return a list of the users mail labels, unread counts for each label and a total unread count.
  """
  @spec mail_labels(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdMailLabelsGet.t()} | {:error, Esi.Api.Error.t()}
  def mail_labels(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :mail_labels},
      url: "/characters/#{character_id}/mail/labels",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdMailLabelsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Return mailing list subscriptions

  Return all mailing lists that the character is subscribed to
  """
  @spec mail_lists(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdMailListsGet.t()]} | {:error, Esi.Api.Error.t()}
  def mail_lists(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :mail_lists},
      url: "/characters/#{character_id}/mail/lists",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdMailListsGet, :t}]},
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
      call: {Esi.Api.Characters, :medals},
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
  Character mining ledger

  Paginated record of all mining done by a character for the past 30 days

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec mining(integer, keyword) :: Enumerable.t()
  def mining(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/mining", opts)
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
      call: {Esi.Api.Characters, :notifications},
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
  Get new contact notifications

  Return notifications about having been added to someone's contact list
  """
  @spec notifications_contacts(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdNotificationsContactsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def notifications_contacts(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :notifications_contacts},
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
  Get character online

  Checks if the character is currently online
  """
  @spec online(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdOnlineGet.t()} | {:error, Esi.Api.Error.t()}
  def online(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :online},
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
  List open orders from a character

  List open market orders placed by a character
  """
  @spec orders(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdOrdersGet.t()]} | {:error, Esi.Api.Error.t()}
  def orders(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :orders},
      url: "/characters/#{character_id}/orders",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdOrdersGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List historical orders by a character

  List cancelled and expired market orders placed by a character up to 90 days in the past.

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec orders_history(integer, keyword) :: Enumerable.t()
  def orders_history(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/orders/history", opts)
  end

  @doc """
  Get colony layout

  Returns full details on the layout of a single planetary colony, including links, pins and routes. Note: Planetary information is only recalculated when the colony is viewed through the client. Information will not update until this criteria is met.
  """
  @spec planet(integer, integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdPlanetsPlanetIdGet.t()} | {:error, Esi.Api.Error.t()}
  def planet(character_id, planet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, planet_id: planet_id],
      call: {Esi.Api.Characters, :planet},
      url: "/characters/#{character_id}/planets/#{planet_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdPlanetsPlanetIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get colonies

  Returns a list of all planetary colonies owned by a character.
  """
  @spec planets(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdPlanetsGet.t()]} | {:error, Esi.Api.Error.t()}
  def planets(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :planets},
      url: "/characters/#{character_id}/planets",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdPlanetsGet, :t}]},
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
      call: {Esi.Api.Characters, :portrait},
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
      call: {Esi.Api.Characters, :roles},
      url: "/characters/#{character_id}/roles",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdRolesGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

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
      call: {Esi.Api.Characters, :search},
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
      call: {Esi.Api.Characters, :ship},
      url: "/characters/#{character_id}/ship",
      method: :get,
      response: [{200, {Esi.Api.CharactersCharacterIdShipGet, :t}}, default: {Esi.Api.Error, :t}],
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
      call: {Esi.Api.Characters, :skillqueue},
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
      call: {Esi.Api.Characters, :skills},
      url: "/characters/#{character_id}/skills",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdSkillsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
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
      call: {Esi.Api.Characters, :standings},
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
      call: {Esi.Api.Characters, :titles},
      url: "/characters/#{character_id}/titles",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdTitlesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Respond to an event

  Set your response status to an event
  """
  @spec update_calendar(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def update_calendar(character_id, event_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, event_id: event_id, body: body],
      call: {Esi.Api.Characters, :update_calendar},
      url: "/characters/#{character_id}/calendar/#{event_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Edit contacts

  Bulk edit contacts with same settings

  ## Options

    * `label_ids`
    * `standing`
    * `watched`

  """
  @spec update_contacts(integer, [integer], keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def update_contacts(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:label_ids, :standing, :watched])

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Characters, :update_contacts},
      url: "/characters/#{character_id}/contacts",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", [:integer]}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Update metadata about a mail

  Update metadata about a mail
  """
  @spec update_mail(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def update_mail(character_id, mail_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, mail_id: mail_id, body: body],
      call: {Esi.Api.Characters, :update_mail},
      url: "/characters/#{character_id}/mail/#{mail_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get a character's wallet balance

  Returns a character's wallet balance
  """
  @spec wallet(integer, keyword) :: {:ok, number} | {:error, Esi.Api.Error.t()}
  def wallet(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :wallet},
      url: "/characters/#{character_id}/wallet",
      method: :get,
      response: [{200, :number}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get character wallet journal

  Retrieve the given character's wallet journal going 30 days back

  **Note:** This endpoint is paginated and returns a stream. The stream automatically
  fetches all pages. Use `Enum` or `Stream` functions to consume the results.

  Example:
  ```elixir
  # Get all results
  results = function_name(...) |> Enum.to_list()

  # Process in chunks
  function_name(...) |> Stream.each(&process/1) |> Stream.run()
  ```
  """
  @spec wallet_journal(integer, keyword) :: Enumerable.t()
  def wallet_journal(character_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/characters/#{character_id}/wallet/journal", opts)
  end

  @doc """
  Get wallet transactions

  Get wallet transactions of a character

  ## Options

    * `from_id`

  """
  @spec wallet_transactions(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdWalletTransactionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def wallet_transactions(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:from_id])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Characters, :wallet_transactions},
      url: "/characters/#{character_id}/wallet/transactions",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdWalletTransactionsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
