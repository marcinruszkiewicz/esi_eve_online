defmodule ESI.API.Incursion do
  @moduledoc """
  Legacy compatibility module for Incursion API endpoints.

  This module provides the same interface as the legacy ESI.API.Incursion module,
  returning ESI.Request structs that work with the legacy request pattern.

  All functions maintain exact compatibility with the legacy library while
  internally mapping to the new Esi.Api.* modules.

  Copied and adapted from the legacy ESI library for perfect compatibility.
  """

  @doc """
  Return a list of current incursions.

  ## Response Example

  A list of incursions:

      [
        %{
          "constellation_id" => 20000607,
          "faction_id" => 500019,
          "has_boss" => true,
          "infested_solar_systems" => [30004148, 30004149, 30004150, 30004151,
           30004152, 30004153, 30004154],
          "influence" => 0.9,
          "staging_solar_system_id" => 30004154,
          "state" => "mobilizing",
          "type" => "Incursion"
        }
      ]

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_incursions`
  - `path` -- `/incursions/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Incursions/get_incursions)

  """
  @spec incursions() :: ESI.Request.t()
  def incursions() do
    %ESI.Request{
      verb: :get,
      path: "/incursions/",
      opts_schema: %{datasource: {:query, :optional}}
    }
  end
end
