defmodule Esi.Api.Corporation do
  @moduledoc """
  Provides API endpoints related to corporation
  """

  @doc """
  Moon extraction timers

  Extraction timers for all moon chunks being extracted by refineries belonging to a corporation.

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
  @spec mining_extractions(integer, keyword) :: Enumerable.t()
  def mining_extractions(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporation/#{corporation_id}/mining/extractions", opts)
  end

  @doc """
  Observed corporation mining

  Paginated record of all mining seen by an observer

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
  @spec mining_observer(integer, integer, keyword) :: Enumerable.t()
  def mining_observer(corporation_id, observer_id, opts \\ []) do
    EsiEveOnline.stream_paginated(
      "/corporation/#{corporation_id}/mining/observers/#{observer_id}",
      opts
    )
  end

  @doc """
  Corporation mining observers

  Paginated list of all entities capable of observing and recording mining for a corporation

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
  @spec mining_observers(integer, keyword) :: Enumerable.t()
  def mining_observers(corporation_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/corporation/#{corporation_id}/mining/observers", opts)
  end
end
