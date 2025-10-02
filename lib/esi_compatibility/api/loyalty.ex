defmodule ESI.API.Loyalty do
  @moduledoc """
  Legacy compatibility module for Loyalty API endpoints.

  Provides access to loyalty point store offers and information.

  This module provides the same interface as the legacy ESI.API.Loyalty module,
  returning ESI.Request structs that work with the legacy request pattern.

  ## Available Functions

  This module contains 1 function:

  - `offers/0` or `offers/1`

  ## Usage

  All functions return `ESI.Request` structs that can be executed using the standard
  ESI request pattern:

      iex> request = ESI.API.Loyalty.some_function(opts)
      iex> ESI.request(request)

  ## Compatibility

  This module maintains exact compatibility with the legacy ESI library while
  internally mapping to the new Esi.Api.* modules. All function names, arguments,
  and return types are preserved.

  Generated from the legacy ESI library for perfect compatibility.
  """

  @doc """
  Return a list of offers from a specific corporation's loyalty store.

  ## Response Example

  A list of offers:

      [
        %{
          "ak_cost" => 35000,
          "isk_cost" => 0,
          "lp_cost" => 100,
          "offer_id" => 1,
          "quantity" => 1,
          "required_items" => [],
          "type_id" => 123
        },
        %{
          "isk_cost" => 1000,
          "lp_cost" => 100,
          "offer_id" => 2,
          "quantity" => 10,
          "required_items" => [%{"quantity" => 10, "type_id" => 1234}],
          "type_id" => 1235
        }
      ]

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_loyalty_stores_corporation_id_offers`
  - `path` -- `/loyalty/stores/{corporation_id}/offers/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Loyalty/get_loyalty_stores_corporation_id_offers)

  """
  @spec offers(corporation_id :: integer) :: ESI.Request.t()
  def offers(corporation_id) do
    %ESI.Request{
      verb: :get,
      path: "/loyalty/stores/#{corporation_id}/offers/",
      opts_schema: %{datasource: {:query, :optional}}
    }
  end
end
