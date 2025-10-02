defmodule ESI.API.Status do
  @moduledoc """
  Legacy compatibility module for Status API endpoints.

  Provides access to EVE Online server status and player count information.

  This module provides the same interface as the legacy ESI.API.Status module,
  returning ESI.Request structs that work with the legacy request pattern.

  ## Available Functions

  This module contains 1 function:

  - `status/0` or `status/1`

  ## Usage

  All functions return `ESI.Request` structs that can be executed using the standard
  ESI request pattern:

      iex> request = ESI.API.Status.some_function(opts)
      iex> ESI.request(request)

  ## Compatibility

  This module maintains exact compatibility with the legacy ESI library while
  internally mapping to the new Esi.Api.* modules. All function names, arguments,
  and return types are preserved.

  Generated from the legacy ESI library for perfect compatibility.
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
