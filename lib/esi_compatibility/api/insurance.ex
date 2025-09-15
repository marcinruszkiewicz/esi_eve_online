defmodule ESI.API.Insurance do
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
