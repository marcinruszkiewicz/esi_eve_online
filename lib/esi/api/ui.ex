defmodule Esi.Api.Ui do
  @moduledoc """
  Provides API endpoints related to ui
  """

  @default_client Esi.Client

  @doc """
  Set Autopilot Waypoint

  Set a solar system as autopilot waypoint

  ## Options

    * `add_to_beginning`
    * `clear_other_waypoints`
    * `destination_id`

  """
  @spec post_autopilot_waypoint(keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def post_autopilot_waypoint(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:add_to_beginning, :clear_other_waypoints, :destination_id])

    client.request(%{
      args: [],
      call: {Esi.Api.Ui, :post_autopilot_waypoint},
      url: "/ui/autopilot/waypoint",
      method: :post,
      query: query,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Open Contract Window

  Open the contract window inside the client

  ## Options

    * `contract_id`

  """
  @spec post_openwindow_contract(keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def post_openwindow_contract(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:contract_id])

    client.request(%{
      args: [],
      call: {Esi.Api.Ui, :post_openwindow_contract},
      url: "/ui/openwindow/contract",
      method: :post,
      query: query,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Open Information Window

  Open the information window for a character, corporation or alliance inside the client

  ## Options

    * `target_id`

  """
  @spec post_openwindow_information(keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def post_openwindow_information(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:target_id])

    client.request(%{
      args: [],
      call: {Esi.Api.Ui, :post_openwindow_information},
      url: "/ui/openwindow/information",
      method: :post,
      query: query,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Open Market Details

  Open the market details window for a specific typeID inside the client

  ## Options

    * `type_id`

  """
  @spec post_openwindow_marketdetails(keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def post_openwindow_marketdetails(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:type_id])

    client.request(%{
      args: [],
      call: {Esi.Api.Ui, :post_openwindow_marketdetails},
      url: "/ui/openwindow/marketdetails",
      method: :post,
      query: query,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Open New Mail Window

  Open the New Mail window, according to settings from the request if applicable
  """
  @spec post_openwindow_newmail(map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def post_openwindow_newmail(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Esi.Api.Ui, :post_openwindow_newmail},
      url: "/ui/openwindow/newmail",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
