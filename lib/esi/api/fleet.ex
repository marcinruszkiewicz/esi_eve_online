defmodule Esi.Api.Fleet do
  @moduledoc """
  Provides API endpoints related to fleet
  """

  @default_client Esi.Client

  @doc """
  Kick fleet member

  Kick a fleet member
  """
  @spec delete_get_members(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_get_members(fleet_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, member_id: member_id],
      call: {Esi.Api.Fleet, :delete_get_members},
      url: "/fleets/#{fleet_id}/members/#{member_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete fleet squad

  Delete a fleet squad, only empty squads can be deleted
  """
  @spec delete_get_squads(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_get_squads(fleet_id, squad_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, squad_id: squad_id],
      call: {Esi.Api.Fleet, :delete_get_squads},
      url: "/fleets/#{fleet_id}/squads/#{squad_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete fleet wing

  Delete a fleet wing, only empty wings can be deleted. The wing may contain squads, but the squads must be empty
  """
  @spec delete_get_wings(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def delete_get_wings(fleet_id, wing_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, wing_id: wing_id],
      call: {Esi.Api.Fleet, :delete_get_wings},
      url: "/fleets/#{fleet_id}/wings/#{wing_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get fleet information

  Return details about a fleet
  """
  @spec get_get(integer, keyword) ::
          {:ok, Esi.Api.FleetsFleetIdGet.t()} | {:error, Esi.Api.Error.t()}
  def get_get(fleet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id],
      call: {Esi.Api.Fleet, :get_get},
      url: "/fleets/#{fleet_id}",
      method: :get,
      response: [{200, {Esi.Api.FleetsFleetIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get fleet members

  Return information about fleet members
  """
  @spec get_members(integer, keyword) ::
          {:ok, [Esi.Api.FleetsFleetIdMembersGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_members(fleet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id],
      call: {Esi.Api.Fleet, :get_members},
      url: "/fleets/#{fleet_id}/members",
      method: :get,
      response: [{200, [{Esi.Api.FleetsFleetIdMembersGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get fleet wings

  Return information about wings in a fleet
  """
  @spec get_wings(integer, keyword) ::
          {:ok, [Esi.Api.FleetsFleetIdWingsGet.t()]} | {:error, Esi.Api.Error.t()}
  def get_wings(fleet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id],
      call: {Esi.Api.Fleet, :get_wings},
      url: "/fleets/#{fleet_id}/wings",
      method: :get,
      response: [{200, [{Esi.Api.FleetsFleetIdWingsGet, :t}]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Create fleet invitation

  Invite a character into the fleet. If a character has a CSPA charge set it is not possible to invite them to the fleet using ESI
  """
  @spec post_members(integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def post_members(fleet_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, body: body],
      call: {Esi.Api.Fleet, :post_members},
      url: "/fleets/#{fleet_id}/members",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Create fleet wing

  Create a new wing in a fleet
  """
  @spec post_wings(integer, keyword) ::
          {:ok, Esi.Api.FleetsFleetIdWingsPost.t()} | {:error, Esi.Api.Error.t()}
  def post_wings(fleet_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id],
      call: {Esi.Api.Fleet, :post_wings},
      url: "/fleets/#{fleet_id}/wings",
      method: :post,
      response: [{201, {Esi.Api.FleetsFleetIdWingsPost, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Create fleet squad

  Create a new squad in a fleet
  """
  @spec post_wings_squads(integer, integer, keyword) ::
          {:ok, Esi.Api.FleetsFleetIdWingsWingIdSquadsPost.t()} | {:error, Esi.Api.Error.t()}
  def post_wings_squads(fleet_id, wing_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, wing_id: wing_id],
      call: {Esi.Api.Fleet, :post_wings_squads},
      url: "/fleets/#{fleet_id}/wings/#{wing_id}/squads",
      method: :post,
      response: [
        {201, {Esi.Api.FleetsFleetIdWingsWingIdSquadsPost, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Update fleet

  Update settings about a fleet
  """
  @spec put_get(integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def put_get(fleet_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, body: body],
      call: {Esi.Api.Fleet, :put_get},
      url: "/fleets/#{fleet_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Move fleet member

  Move a fleet member around
  """
  @spec put_get_members(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def put_get_members(fleet_id, member_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, member_id: member_id, body: body],
      call: {Esi.Api.Fleet, :put_get_members},
      url: "/fleets/#{fleet_id}/members/#{member_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Rename fleet squad

  Rename a fleet squad
  """
  @spec put_get_squads(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def put_get_squads(fleet_id, squad_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, squad_id: squad_id, body: body],
      call: {Esi.Api.Fleet, :put_get_squads},
      url: "/fleets/#{fleet_id}/squads/#{squad_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Rename fleet wing

  Rename a fleet wing
  """
  @spec put_get_wings(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def put_get_wings(fleet_id, wing_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fleet_id: fleet_id, wing_id: wing_id, body: body],
      call: {Esi.Api.Fleet, :put_get_wings},
      url: "/fleets/#{fleet_id}/wings/#{wing_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
