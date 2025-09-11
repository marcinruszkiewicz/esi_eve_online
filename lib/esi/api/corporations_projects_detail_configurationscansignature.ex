defmodule Esi.Api.CorporationsProjectsDetailConfigurationscansignature do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationscansignature
  """

  @type t :: %__MODULE__{
          locations:
            [Esi.Api.ConstellationId.t() | Esi.Api.RegionId.t() | Esi.Api.SolarSystemId.t()] | nil,
          signatures: [Esi.Api.CorporationsProjectsDetailConfigurationmatchersignature.t()] | nil
        }

  defstruct [:locations, :signatures]

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
      ],
      signatures: [{Esi.Api.CorporationsProjectsDetailConfigurationmatchersignature, :t}]
    ]
  end
end
