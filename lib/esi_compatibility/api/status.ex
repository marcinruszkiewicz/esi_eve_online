defmodule ESI.API.Status do
  @moduledoc """
  Legacy compatibility module for Status API endpoints.

  This module provides the same interface as the legacy ESI.API.Status module,
  returning ESI.Request structs that work with the legacy request pattern.

  All functions maintain exact compatibility with the legacy library while
  internally mapping to the new Esi.Api.* modules.

  Copied and adapted from the legacy ESI library for perfect compatibility.
  """

  @doc """
  EVE Server status.

  ## Response Example

  Server status:

      %{
        "players" => 12345,
        "server_version" => "1132976",
        "start_time" => "2017-01-02T12:34:56Z"
      }

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_status`
  - `path` -- `/status/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Status/get_status)

  """
  @spec status() :: ESI.Request.t()
  def status() do
    %ESI.Request{
      verb: :get,
      path: "/status/",
      opts_schema: %{datasource: {:query, :optional}}
    }
  end
end
