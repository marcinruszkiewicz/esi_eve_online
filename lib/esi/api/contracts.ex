defmodule Esi.Api.Contracts do
  @moduledoc """
  Provides API endpoints related to contracts
  """

  @doc """
  Get public contracts

  Returns a paginated list of all public contracts in the given region

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
  @spec public(integer, keyword) :: Enumerable.t()
  def public(region_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/contracts/public/#{region_id}", opts)
  end

  @doc """
  Get public contract bids

  Lists bids on a public auction contract

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
  @spec public_bid(integer, keyword) :: Enumerable.t()
  def public_bid(contract_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/contracts/public/bids/#{contract_id}", opts)
  end

  @doc """
  Get public contract items

  Lists items of a public contract

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
  @spec public_item(integer, keyword) :: Enumerable.t()
  def public_item(contract_id, opts \\ []) do
    EsiEveOnline.stream_paginated("/contracts/public/items/#{contract_id}", opts)
  end
end
