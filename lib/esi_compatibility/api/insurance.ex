defmodule ESI.API.Insurance do
  @moduledoc """
  Legacy compatibility module for Insurance API endpoints.

  Provides access to ship insurance pricing information.

  This module provides the same interface as the legacy ESI.API.Insurance module,
  returning ESI.Request structs that work with the legacy request pattern.

  ## Available Functions

  This module contains 1 function:

  - `prices/0` or `prices/1`

  ## Usage

  All functions return `ESI.Request` structs that can be executed using the standard
  ESI request pattern:

      iex> request = ESI.API.Insurance.some_function(opts)
      iex> ESI.request(request)

  ## Compatibility

  This module maintains exact compatibility with the legacy ESI library while
  internally mapping to the new Esi.Api.* modules. All function names, arguments,
  and return types are preserved.

  Generated from the legacy ESI library for perfect compatibility.
  """

  @typedoc """
  Options for [`Insurance.prices/1`](#prices/1).

  - `:language` (DEFAULT: `:en`) -- Language to use in the response, takes precedence over Accept-Language
  """
  @type prices_opts :: [prices_opt]
  @type prices_opt :: {:language, nil | :en | :"en-us" | :de | :fr | :ja | :ru | :zh | :ko | :es}

  @doc """
  Return available insurance levels for all ship types.

  ## Response Example

  A list of insurance levels for all ship types:

      [
        %{
          "levels" => [%{"cost" => 10.01, "name" => "Basic", "payout" => 20.01}],
          "type_id" => 1
        }
      ]

  ## Swagger Source

  This function was generated from the following Swagger operation:

  - `operationId` -- `get_insurance_prices`
  - `path` -- `/insurance/prices/`

  [View on ESI Site](https://esi.evetech.net/latest/#!/Insurance/get_insurance_prices)

  """
  @spec prices(opts :: prices_opts) :: ESI.Request.t()
  def prices(opts \\ []) do
    %ESI.Request{
      verb: :get,
      path: "/insurance/prices/",
      opts_schema: %{language: {:query, :optional}, datasource: {:query, :optional}},
      opts: Map.new(opts)
    }
  end
end
