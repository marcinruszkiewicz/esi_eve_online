defmodule Esi.Api.Corporation do
  @moduledoc """
  Provides API endpoints related to corporation
  """

  @default_client Esi.Api.Client

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
  Get corporation information

  Public information about a corporation
  """
  @spec corporations(integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdGet.t()} | {:error, Esi.Api.Error.t()}
  def corporations(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :corporations},
      url: "/corporations/#{corporation_id}",
      method: :get,
      response: [{200, {Esi.Api.CorporationsCorporationIdGet, :t}}, default: {Esi.Api.Error, :t}],
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
  Get corporation member roles history

  Return how roles have changed for a coporation's members, up to a month

  ## Options

    * `page`

  """
  @spec history(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdRolesHistoryGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def history(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :history},
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
  Get corporation issued medals

  Returns medals issued by a corporation

  ## Options

    * `page`

  """
  @spec issued(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdMedalsIssuedGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def issued(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :issued},
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
  Get corporation member limit

  Return a corporation's member limit, not including CEO himself
  """
  @spec limit(integer, keyword) :: {:ok, integer} | {:error, Esi.Api.Error.t()}
  def limit(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :limit},
      url: "/corporations/#{corporation_id}/members/limit",
      method: :get,
      response: [{200, :integer}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get all corporation ALSC logs

  Returns logs recorded in the past seven days from all audit log secure containers (ALSC) owned by a given corporation

  ## Options

    * `page`

  """
  @spec logs(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdContainersLogsGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def logs(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :logs},
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
  @spec starbases(integer, integer, keyword) ::
          {:ok, Esi.Api.CorporationsCorporationIdStarbasesStarbaseIdGet.t()}
          | {:error, Esi.Api.Error.t()}
  def starbases(corporation_id, starbase_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:system_id])

    client.request(%{
      args: [corporation_id: corporation_id, starbase_id: starbase_id],
      call: {Esi.Api.Corporation, :starbases},
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
  Get corporation's members' titles

  Returns a corporation's members' titles
  """
  @spec titles(integer, keyword) ::
          {:ok, [Esi.Api.CorporationsCorporationIdMembersTitlesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def titles(corporation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id],
      call: {Esi.Api.Corporation, :titles},
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
end
