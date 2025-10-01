defmodule Esi.Api.Wars do
  @moduledoc """
  Provides API endpoints related to wars
  """

  @default_client Esi.Client

  @doc """
  List kills for a war

  Return a list of kills related to a war

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
  @spec killmails(integer, keyword) :: Enumerable.t()
  def killmails(war_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/wars/#{war_id}/killmails", opts)
  end

  @doc """
  Get war information

  Return details about a war
  """
  @spec war(integer, keyword) :: {:ok, Esi.Api.WarsWarIdGet.t()} | {:error, Esi.Api.Error.t()}
  def war(war_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [war_id: war_id],
      call: {Esi.Api.Wars, :war},
      url: "/wars/#{war_id}",
      method: :get,
      response: [{200, {Esi.Api.WarsWarIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List wars

  Return a list of wars

  ## Options

    * `max_war_id`

  """
  @spec wars(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def wars(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:max_war_id])

    client.request(%{
      args: [],
      call: {Esi.Api.Wars, :wars},
      url: "/wars",
      method: :get,
      query: query,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
