defmodule ESI.API.Route do
  @moduledoc """
  Legacy compatibility module for Route API endpoints.

  This module provides the same interface as the legacy ESI.API.Route module,
  returning ESI.Request structs that work with the legacy request pattern.

  All functions maintain exact compatibility with the legacy library while
  internally mapping to the new Esi.Api.* modules.

  Copied and adapted from the legacy ESI library for perfect compatibility.
  """

  @typedoc """
  Options for [`Route.route/3`](#route/3).

  - `:avoid` -- avoid solar system ID(s)
  - `:connections` -- connected solar system pairs
  - `:flag` (DEFAULT: `:shortest`) -- route security preference
  """
  @type route_opts :: [route_opt]
  @type route_opt ::
          {:avoid, nil | [integer]}
          | {:connections, nil | [[integer]]}
          | {:flag, nil | :shortest | :secure | :insecure}

  @doc """
  Get the systems between origin and destination.

  ## Response Example

  Solar systems in route from origin to destination:

      [30002771, 30002770, 30002769, 30002772]

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_route_origin_destination`
  - `path` -- `/route/{origin}/{destination}/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Routes/get_route_origin_destination)

  """
  @spec route(origin :: integer, destination :: integer, opts :: route_opts) :: ESI.Request.t()
  def route(origin, destination, opts \\ []) do
    %ESI.Request{
      verb: :get,
      path: "/route/#{origin}/#{destination}/",
      opts_schema: %{
        flag: {:query, :optional},
        datasource: {:query, :optional},
        avoid: {:query, :optional},
        connections: {:query, :optional}
      },
      opts: Map.new(opts)
    }
  end
end
