defmodule Esi.Api.Corporation do
  @moduledoc """
  Provides API endpoints related to corporation
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
      call: {Esi.Api.Corporation, :alliancehistory},
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

  ## Options

    * `page`

  """
  @spec assets(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdAssetsGet.t()]} | {:error, Esi.Api.Error.t()}
  def assets(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :assets},
      url: "/corporations/#{corporation_id}/assets",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdAssetsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :assets_locations},
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
      call: {Esi.Api.Corporation, :assets_names},
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

  ## Options

    * `page`

  """
  @spec blueprints(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdBlueprintsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def blueprints(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :blueprints},
      url: "/corporations/#{corporation_id}/blueprints",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdBlueprintsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation contacts

  Return contacts of a corporation

  ## Options

    * `page`

  """
  @spec contacts(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContactsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contacts(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :contacts},
      url: "/corporations/#{corporation_id}/contacts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContactsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :contacts_labels},
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

  ## Options

    * `page`

  """
  @spec containers_logs(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContainersLogsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def containers_logs(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :containers_logs},
      url: "/corporations/#{corporation_id}/containers/logs",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContainersLogsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation contracts

  Returns contracts available to a corporation, only if the corporation is issuer, acceptor or assignee. Only returns contracts no older than 30 days, or if the status is "in_progress".

  ## Options

    * `page`

  """
  @spec contracts(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContractsGet.t()]} | {:error, Esi.Api.Error.t()}
  def contracts(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :contracts},
      url: "/corporations/#{corporation_id}/contracts",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContractsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation contract bids

  Lists bids on a particular auction contract

  ## Options

    * `page`

  """
  @spec contracts_bids(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContractsContractIdBidsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def contracts_bids(contract_id, corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [contract_id: contract_id, corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :contracts_bids},
      url: "/corporations/#{corporation_id}/contracts/#{contract_id}/bids",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdContractsContractIdBidsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :contracts_items},
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
      call: {Esi.Api.Corporation, :corporation},
      url: "/corporations/#{corporation_id}",
      method: :get,
      response: [{200, {Esi.Api.CorporationsCorporationIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List corporation customs offices

  List customs offices owned by a corporation

  ## Options

    * `page`

  """
  @spec customs_offices(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdCustomsOfficesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def customs_offices(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :customs_offices},
      url: "/corporations/#{corporation_id}/customs_offices",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdCustomsOfficesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :divisions},
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
      call: {Esi.Api.Corporation, :facilities},
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
      call: {Esi.Api.Corporation, :fw_stats},
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
      call: {Esi.Api.Corporation, :icons},
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
    * `page`

  """
  @spec industry_jobs(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdIndustryJobsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def industry_jobs(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include_completed, :page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :industry_jobs},
      url: "/corporations/#{corporation_id}/industry/jobs",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdIndustryJobsGet, :t}]},
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
  @spec killmails_recent(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdKillmailsRecentGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def killmails_recent(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :killmails_recent},
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

  @doc """
  Get corporation medals

  Returns a corporation's medals

  ## Options

    * `page`

  """
  @spec medals(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdMedalsGet.t()]} | {:error, Esi.Api.Error.t()}
  def medals(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :medals},
      url: "/corporations/#{corporation_id}/medals",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdMedalsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation issued medals

  Returns medals issued by a corporation

  ## Options

    * `page`

  """
  @spec medals_issued(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdMedalsIssuedGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def medals_issued(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :medals_issued},
      url: "/corporations/#{corporation_id}/medals/issued",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdMedalsIssuedGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :members},
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
      call: {Esi.Api.Corporation, :members_limit},
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
      call: {Esi.Api.Corporation, :members_titles},
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
      call: {Esi.Api.Corporation, :membertracking},
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
  Moon extraction timers

  Extraction timers for all moon chunks being extracted by refineries belonging to a corporation.

  ## Options

    * `page`

  """
  @spec mining_extractions(integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningExtractionsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def mining_extractions(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :mining_extractions},
      url: "/corporation/#{corporation_id}/mining/extractions",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationCorporationIdMiningExtractionsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Observed corporation mining

  Paginated record of all mining seen by an observer

  ## Options

    * `page`

  """
  @spec mining_observer(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningObserversObserverIdGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def mining_observer(corporation_id, observer_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id, observer_id: observer_id],
      call: {Esi.Api.Corporation, :mining_observer},
      url: "/corporation/#{corporation_id}/mining/observers/#{observer_id}",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationCorporationIdMiningObserversObserverIdGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Corporation mining observers

  Paginated list of all entities capable of observing and recording mining for a corporation

  ## Options

    * `page`

  """
  @spec mining_observers(integer, keyword) ::
          {:ok, [Esi.Api.CorporationCorporationIdMiningObserversGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def mining_observers(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :mining_observers},
      url: "/corporation/#{corporation_id}/mining/observers",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationCorporationIdMiningObserversGet, :t}]},
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
      call: {Esi.Api.Corporation, :npccorps},
      url: "/corporations/npccorps",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List open orders from a corporation

  List open market orders placed on behalf of a corporation

  ## Options

    * `page`

  """
  @spec orders(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdOrdersGet.t()]} | {:error, Esi.Api.Error.t()}
  def orders(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :orders},
      url: "/corporations/#{corporation_id}/orders",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdOrdersGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  List historical orders from a corporation

  List cancelled and expired market orders placed on behalf of a corporation up to 90 days in the past.

  ## Options

    * `page`

  """
  @spec orders_history(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdOrdersHistoryGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def orders_history(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :orders_history},
      url: "/corporations/#{corporation_id}/orders/history",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdOrdersHistoryGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :project},
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
      call: {Esi.Api.Corporation, :projects},
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
      call: {Esi.Api.Corporation, :projects_contribution_item},
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
      call: {Esi.Api.Corporation, :projects_contributors},
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
      call: {Esi.Api.Corporation, :roles},
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

  ## Options

    * `page`

  """
  @spec roles_history(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdRolesHistoryGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def roles_history(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :roles_history},
      url: "/corporations/#{corporation_id}/roles/history",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdRolesHistoryGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation shareholders

  Return the current shareholders of a corporation.

  ## Options

    * `page`

  """
  @spec shareholders(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdShareholdersGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def shareholders(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :shareholders},
      url: "/corporations/#{corporation_id}/shareholders",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdShareholdersGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation standings

  Return corporation standings from agents, NPC corporations, and factions

  ## Options

    * `page`

  """
  @spec standings(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdStandingsGet.t()]} | {:error, Esi.Api.Error.t()}
  def standings(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :standings},
      url: "/corporations/#{corporation_id}/standings",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdStandingsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :starbas},
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

  ## Options

    * `page`

  """
  @spec starbases(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdStarbasesGet.t()]} | {:error, Esi.Api.Error.t()}
  def starbases(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :starbases},
      url: "/corporations/#{corporation_id}/starbases",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdStarbasesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get corporation structures

  Get a list of corporation structures. This route's version includes the changes to structures detailed in this blog: https://www.eveonline.com/article/upwell-2.0-structures-changes-coming-on-february-13th

  ## Options

    * `page`

  """
  @spec structures(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdStructuresGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def structures(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :structures},
      url: "/corporations/#{corporation_id}/structures",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdStructuresGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :titles},
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
      call: {Esi.Api.Corporation, :wallets},
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

  ## Options

    * `page`

  """
  @spec wallets_journal(integer, integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdWalletsDivisionJournalGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def wallets_journal(corporation_id, division, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id, division: division],
      call: {Esi.Api.Corporation, :wallets_journal},
      url: "/corporations/#{corporation_id}/wallets/#{division}/journal",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CorporationsCorporationIdWalletsDivisionJournalGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
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
      call: {Esi.Api.Corporation, :wallets_transactions},
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
