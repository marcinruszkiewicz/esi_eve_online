defmodule Esi.Api.Corporations do
  @moduledoc """
  Provides API endpoints related to corporations
  """

  @default_client Esi.Client

  @doc """
  Get alliance history

  Get a list of all the alliances a corporation has been a member of
  """
  @spec alliancehistory(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAlliancehistoryGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def alliancehistory(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :alliancehistory},
      url: "/corporations/#{corporation_id}/alliancehistory",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAlliancehistoryGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation assets

  Return a list of the corporation assets

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
  def assets(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/assets", opts)
  end

  @doc """
  Get corporation asset locations

  Return locations for a set of item ids, which you can get from corporation assets endpoint. Coordinates for items in hangars or stations are set to (0,0,0)
  """
  @spec assets_locations(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAssetsLocationsPost.t()]}
          | {:error, Esi.Api.Error.t()}
  def assets_locations(corporation_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, body: body],
      call: {Esi.Api.Corporations, :assets_locations},
      url: "/corporations/#{corporation_id}/assets/locations",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAssetsLocationsPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation asset names

  Return names for a set of item ids, which you can get from corporation assets endpoint. Only valid for items that can customize names, like containers or ships
  """
  @spec assets_names(integer, [integer], keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAssetsNamesPost.t()]}
          | {:error, Esi.Api.Error.t()}
  def assets_names(corporation_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, body: body],
      call: {Esi.Api.Corporations, :assets_names},
      url: "/corporations/#{corporation_id}/assets/names",
      body: body,
      method: :post,
      request: [{"application/json", [:integer]}],
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAssetsNamesPost, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation blueprints

  Returns a list of blueprints the corporation owns

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
  def blueprints(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/blueprints", opts)
  end

  @doc """
  Get corporation contacts

  Return contacts of a corporation

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
  def contacts(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/contacts", opts)
  end

  @doc """
  Get corporation contact labels

  Return custom labels for a corporation's contacts
  """
  @spec contacts_labels(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContactsLabelsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contacts_labels(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :contacts_labels},
      url: "/corporations/#{corporation_id}/contacts/labels",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContactsLabelsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get all corporation ALSC logs

  Returns logs recorded in the past seven days from all audit log secure containers (ALSC) owned by a given corporation

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
  @spec containers_logs(integer, keyword) :: Enumerable.t()
  def containers_logs(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/containers/logs", opts)
  end

  @doc """
  Get corporation contracts

  Returns contracts available to a corporation, only if the corporation is issuer, acceptor or assignee. Only returns contracts no older than 30 days, or if the status is "in_progress".

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
  def contracts(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/contracts", opts)
  end

  @doc """
  Get corporation contract bids

  Lists bids on a particular auction contract

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
  @spec contracts_bids(integer, integer, keyword) :: Enumerable.t()
  def contracts_bids(contract_id, corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated(
      "/corporations/#{corporation_id}/contracts/#{contract_id}/bids",
      opts
    )
  end

  @doc """
  Get corporation contract items

  Lists items of a particular contract
  """
  @spec contracts_items(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContractsContractIdItemsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contracts_items(contract_id, corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [contract_id: contract_id, corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :contracts_items},
      url: "/corporations/#{corporation_id}/contracts/#{contract_id}/items",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContractsContractIdItemsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation information

  Public information about a corporation
  """
  @spec corporation(integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdGet.t()} | {:error, Esi.Api.Error.t()}
  def corporation(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :corporation},
      url: "/corporations/#{corporation_id}",
      method: :get,
      response: [{200, {Esi.Api.CorporationsCorporationIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List corporation customs offices

  List customs offices owned by a corporation

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
  @spec customs_offices(integer, keyword) :: Enumerable.t()
  def customs_offices(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/customs_offices", opts)
  end

  @doc """
  Get corporation divisions

  Return corporation hangar and wallet division names, only show if a division is not using the default name
  """
  @spec divisions(integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdDivisionsGet.t()} | {:error, Esi.Api.Error.t()}
  def divisions(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :divisions},
      url: "/corporations/#{corporation_id}/divisions",
      method: :get,
      response: [
        {200, {Esi.Api.CorporationsCorporationIdDivisionsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation facilities

  Return a corporation's facilities
  """
  @spec facilities(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdFacilitiesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def facilities(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :facilities},
      url: "/corporations/#{corporation_id}/facilities",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdFacilitiesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Overview of a corporation involved in faction warfare

  Statistics about a corporation involved in faction warfare

  This route expires daily at 11:05
  """
  @spec fw_stats(integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdFwStatsGet.t()} | {:error, Esi.Api.Error.t()}
  def fw_stats(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :fw_stats},
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
  Get corporation icon

  Get the icon urls for a corporation
  """
  @spec icons(integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdIconsGet.t()} | {:error, Esi.Api.Error.t()}
  def icons(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :icons},
      url: "/corporations/#{corporation_id}/icons",
      method: :get,
      response: [
        {200, {Esi.Api.CorporationsCorporationIdIconsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List corporation industry jobs

  List industry jobs run by a corporation

  ## Options

    * `include_completed`


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
  @spec industry_jobs(integer, keyword) :: Enumerable.t()
  def industry_jobs(corporation_id, opts \\ []) do
    query_opts = Keyword.take(opts, [:include_completed])
    all_opts = Keyword.merge(query_opts, opts)
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/industry/jobs", all_opts)
  end

  @doc """
  Get a corporation's recent kills and losses

  Get a list of a corporation's kills and losses going back 90 days

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
  def killmails_recent(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/killmails/recent", opts)
  end

  @doc """
  Get corporation medals

  Returns a corporation's medals

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
  @spec medals(integer, keyword) :: Enumerable.t()
  def medals(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/medals", opts)
  end

  @doc """
  Get corporation issued medals

  Returns medals issued by a corporation

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
  @spec medals_issued(integer, keyword) :: Enumerable.t()
  def medals_issued(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/medals/issued", opts)
  end

  @doc """
  Get corporation members

  Return the current member list of a corporation, the token's character need to be a member of the corporation.
  """
  @spec members(integer, keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def members(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :members},
      url: "/corporations/#{corporation_id}/members",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get corporation member limit

  Return a corporation's member limit, not including CEO himself
  """
  @spec members_limit(integer, keyword) :: {:ok, integer} | {:error, Esi.Api.Error.t()}
  def members_limit(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :members_limit},
      url: "/corporations/#{corporation_id}/members/limit",
      method: :get,
      response: [{200, :integer}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get corporation's members' titles

  Returns a corporation's members' titles
  """
  @spec members_titles(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdMembersTitlesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def members_titles(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :members_titles},
      url: "/corporations/#{corporation_id}/members/titles",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdMembersTitlesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Track corporation members

  Returns additional information about a corporation's members which helps tracking their activities
  """
  @spec membertracking(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdMembertrackingGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def membertracking(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :membertracking},
      url: "/corporations/#{corporation_id}/membertracking",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdMembertrackingGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get npc corporations

  Get a list of npc corporations

  This route expires daily at 11:05
  """
  @spec npccorps(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def npccorps(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Corporations, :npccorps},
      url: "/corporations/npccorps",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List open orders from a corporation

  List open market orders placed on behalf of a corporation

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
  @spec orders(integer, keyword) :: Enumerable.t()
  def orders(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/orders", opts)
  end

  @doc """
  List historical orders from a corporation

  List cancelled and expired market orders placed on behalf of a corporation up to 90 days in the past.

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
  def orders_history(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/orders/history", opts)
  end

  @doc """
  Get project details

  Get the details of a corporation project.
  """
  @spec project(integer, String.t(), keyword) ::
          {:ok, Esi.Api.CorporationsProjectsDetail.t()} | {:error, Esi.Api.Error.t()}
  def project(corporation_id, project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, project_id: project_id],
      call: {Esi.Api.Corporations, :project},
      url: "/corporations/#{corporation_id}/projects/#{project_id}",
      method: :get,
      response: [{200, {Esi.Api.CorporationsProjectsDetail, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List corporation projects

  Listing of all (active) corporation projects.

  ## Options

    * `after`: Return records from after this cursor (mutual exclusive with 'before'). '0' to start from the beginning.
    * `before`: Return records from before this cursor (mutual exclusive with 'after'). '0' to start from the end.
    * `limit`: The amount of records to retrieve per request.
    * `state`: Filter by state

  """
  @spec projects(integer, keyword) ::
          {:ok, Esi.Api.CorporationsProjectsListing.t()} | {:error, Esi.Api.Error.t()}
  def projects(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:after, :before, :limit, :state])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :projects},
      url: "/corporations/#{corporation_id}/projects",
      method: :get,
      query: query,
      response: [{200, {Esi.Api.CorporationsProjectsListing, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get your project contribution

  Show your contribution to a corporation project.
  """
  @spec projects_contribution_item(integer, String.t(), integer, keyword) ::
          {:ok, Esi.Api.CorporationsProjectsContribution.t()} | {:error, Esi.Api.Error.t()}
  def projects_contribution_item(corporation_id, project_id, character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, project_id: project_id, character_id: character_id],
      call: {Esi.Api.Corporations, :projects_contribution_item},
      url: "/corporations/#{corporation_id}/projects/#{project_id}/contribution/#{character_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CorporationsProjectsContribution, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List project contributors

  Listing of all contributors to a corporation project.

  ## Options

    * `after`: Return records from after this cursor (mutual exclusive with 'before'). '0' to start from the beginning.
    * `before`: Return records from before this cursor (mutual exclusive with 'after'). '0' to start from the end.
    * `limit`: The amount of records to retrieve per request.

  """
  @spec projects_contributors(integer, String.t(), keyword) ::
          {:ok, Esi.Api.CorporationsProjectsContributors.t()} | {:error, Esi.Api.Error.t()}
  def projects_contributors(corporation_id, project_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:after, :before, :limit])

    client.request(%{
      args: [corporation_id: corporation_id, project_id: project_id],
      call: {Esi.Api.Corporations, :projects_contributors},
      url: "/corporations/#{corporation_id}/projects/#{project_id}/contributors",
      method: :get,
      query: query,
      response: [
        {200, {Esi.Api.CorporationsProjectsContributors, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation member roles

  Return the roles of all members if the character has the personnel manager role or any grantable role.
  """
  @spec roles(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdRolesGet.t()]} | {:error, Esi.Api.Error.t()}
  def roles(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :roles},
      url: "/corporations/#{corporation_id}/roles",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdRolesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation member roles history

  Return how roles have changed for a coporation's members, up to a month

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
  @spec roles_history(integer, keyword) :: Enumerable.t()
  def roles_history(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/roles/history", opts)
  end

  @doc """
  Get corporation shareholders

  Return the current shareholders of a corporation.

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
  @spec shareholders(integer, keyword) :: Enumerable.t()
  def shareholders(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/shareholders", opts)
  end

  @doc """
  Get corporation standings

  Return corporation standings from agents, NPC corporations, and factions

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
  @spec standings(integer, keyword) :: Enumerable.t()
  def standings(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/standings", opts)
  end

  @doc """
  Get starbase (POS) detail

  Returns various settings and fuels of a starbase (POS)

  ## Options

    * `system_id`

  """
  @spec starbas(integer, integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdStarbasesStarbaseIdGet.t()}
          | {:error, Esi.Api.Error.t()}
  def starbas(corporation_id, starbase_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:system_id])

    client.request(%{
      args: [corporation_id: corporation_id, starbase_id: starbase_id],
      call: {Esi.Api.Corporations, :starbas},
      url: "/corporations/#{corporation_id}/starbases/#{starbase_id}",
      method: :get,
      query: query,
      response: [
        {200, {Esi.Api.CorporationsCorporationIdStarbasesStarbaseIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation starbases (POSes)

  Returns list of corporation starbases (POSes)

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
  @spec starbases(integer, keyword) :: Enumerable.t()
  def starbases(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/starbases", opts)
  end

  @doc """
  Get corporation structures

  Get a list of corporation structures. This route's version includes the changes to structures detailed in this blog: https://www.eveonline.com/article/upwell-2.0-structures-changes-coming-on-february-13th

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
  @spec structures(integer, keyword) :: Enumerable.t()
  def structures(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporations/#{corporation_id}/structures", opts)
  end

  @doc """
  Get corporation titles

  Returns a corporation's titles
  """
  @spec titles(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdTitlesGet.t()]} | {:error, Esi.Api.Error.t()}
  def titles(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :titles},
      url: "/corporations/#{corporation_id}/titles",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdTitlesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Returns a corporation's wallet balance

  Get a corporation's wallets
  """
  @spec wallets(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdWalletsGet.t()]} | {:error, Esi.Api.Error.t()}
  def wallets(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporations, :wallets},
      url: "/corporations/#{corporation_id}/wallets",
      method: :get,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdWalletsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation wallet journal

  Retrieve the given corporation's wallet journal for the given division going 30 days back

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
  @spec wallets_journal(integer, integer, keyword) :: Enumerable.t()
  def wallets_journal(corporation_id, division, opts \\ []) do
    EsiEveOnline.stream_paginated(
      "/corporations/#{corporation_id}/wallets/#{division}/journal",
      opts
    )
  end

  @doc """
  Get corporation wallet transactions

  Get wallet transactions of a corporation

  ## Options

    * `from_id`

  """
  @spec wallets_transactions(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdWalletsDivisionTransactionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def wallets_transactions(corporation_id, division, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:from_id])

    client.request(%{
      args: [corporation_id: corporation_id, division: division],
      call: {Esi.Api.Corporations, :wallets_transactions},
      url: "/corporations/#{corporation_id}/wallets/#{division}/transactions",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdWalletsDivisionTransactionsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
