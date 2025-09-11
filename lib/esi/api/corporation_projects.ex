defmodule Esi.Api.CorporationProjects do
  @moduledoc """
  Provides API endpoints related to corporation projects
  """

  @default_client Esi.Api.Client

  @doc """
  Get your project contribution

  Show your contribution to a corporation project.
  """
  @spec contribution(integer, String.t(), integer, keyword) ::
          {:ok, Esi.Api.CorporationsProjectsContribution.t()} | {:error, Esi.Api.Error.t()}
  def contribution(corporation_id, project_id, character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, project_id: project_id, character_id: character_id],
      call: {Esi.Api.CorporationProjects, :contribution},
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
  @spec contributors(integer, String.t(), keyword) ::
          {:ok, Esi.Api.CorporationsProjectsContributors.t()} | {:error, Esi.Api.Error.t()}
  def contributors(corporation_id, project_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:after, :before, :limit])

    client.request(%{
      args: [corporation_id: corporation_id, project_id: project_id],
      call: {Esi.Api.CorporationProjects, :contributors},
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
      call: {Esi.Api.CorporationProjects, :projects},
      url: "/corporations/#{corporation_id}/projects",
      method: :get,
      query: query,
      response: [{200, {Esi.Api.CorporationsProjectsListing, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get project details

  Get the details of a corporation project.
  """
  @spec projects(integer, String.t(), keyword) ::
          {:ok, Esi.Api.CorporationsProjectsDetail.t()} | {:error, Esi.Api.Error.t()}
  def projects(corporation_id, project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [corporation_id: corporation_id, project_id: project_id],
      call: {Esi.Api.CorporationProjects, :projects},
      url: "/corporations/#{corporation_id}/projects/#{project_id}",
      method: :get,
      response: [{200, {Esi.Api.CorporationsProjectsDetail, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
