defmodule ESI.API.Industry do
  @moduledoc """
  Legacy compatibility module for Industry API endpoints.

  This module provides the same interface as the legacy ESI.API.Industry module,
  returning ESI.Request structs that work with the legacy request pattern.

  All functions maintain exact compatibility with the legacy library while
  internally mapping to the new Esi.Api.* modules.

  Copied and adapted from the legacy ESI library for perfect compatibility.
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
