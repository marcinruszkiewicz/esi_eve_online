defmodule Esi.Api.CorporationsProjectsDetailConfigurationsalvagewreck do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationsalvagewreck
  """

  @type t :: %__MODULE__{
          locations:
            [Esi.Api.ConstellationId.t() | Esi.Api.RegionId.t() | Esi.Api.SolarSystemId.t()] | nil
        }

  defstruct [:locations]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      locations: [
        union: [
          {Esi.Api.ConstellationId, :t},
          {Esi.Api.RegionId, :t},
          {Esi.Api.SolarSystemId, :t}
        ]
      ]
    ]
  end
end
