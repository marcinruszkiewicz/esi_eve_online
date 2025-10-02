defmodule ESI.API.Industry do
  @moduledoc """
  Legacy compatibility module for Industry API endpoints.

  Provides access to industry jobs, facilities, and manufacturing information.

  This module provides the same interface as the legacy ESI.API.Industry module,
  returning ESI.Request structs that work with the legacy request pattern.

  ## Available Functions

  This module contains 2 functions:

  - `systems/0` or `systems/1`
      - `facilities/0` or `facilities/1`

  ## Usage

  All functions return `ESI.Request` structs that can be executed using the standard
  ESI request pattern:

      iex> request = ESI.API.Industry.some_function(opts)
      iex> ESI.request(request)

  ## Compatibility

  This module maintains exact compatibility with the legacy ESI library while
  internally mapping to the new Esi.Api.* modules. All function names, arguments,
  and return types are preserved.

  Generated from the legacy ESI library for perfect compatibility.
  """

  @doc """
  Return cost indices for solar systems.

  ## Response Example

  A list of cost indicies:

      [
        %{
          "cost_indices" => [%{"activity" => "invention", "cost_index" => 0.0048}],
          "solar_system_id" => 30011392
        }
      ]

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_industry_systems`
  - `path` -- `/industry/systems/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Industry/get_industry_systems)

  """
  @spec systems() :: ESI.Request.t()
  def systems() do
    %ESI.Request{
      verb: :get,
      path: "/industry/systems/",
      opts_schema: %{datasource: {:query, :optional}}
    }
  end

  @doc """
  Return a list of industry facilities.

  ## Response Example

  A list of facilities:

      [
        %{
          "facility_id" => 60012544,
          "owner_id" => 1000126,
          "region_id" => 10000001,
          "solar_system_id" => 30000032,
          "tax" => 0.1,
          "type_id" => 2502
        }
      ]

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_industry_facilities`
  - `path` -- `/industry/facilities/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Industry/get_industry_facilities)

  """
  @spec facilities() :: ESI.Request.t()
  def facilities() do
    %ESI.Request{
      verb: :get,
      path: "/industry/facilities/",
      opts_schema: %{datasource: {:query, :optional}}
    }
  end
end
