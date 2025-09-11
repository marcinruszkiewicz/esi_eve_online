defmodule Esi.Api.CorporationsProjectsDetailConfigurationcapturefwcomplex do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationcapturefwcomplex
  """

  @type t :: %__MODULE__{
          archetypes: [Esi.Api.CorporationsProjectsDetailConfigurationmatcherarchetype.t()] | nil,
          factions: [Esi.Api.CorporationsProjectsDetailConfigurationmatcherfaction.t()] | nil,
          locations:
            [Esi.Api.ConstellationId.t() | Esi.Api.RegionId.t() | Esi.Api.SolarSystemId.t()] | nil
        }

  defstruct [:archetypes, :factions, :locations]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      archetypes: [{Esi.Api.CorporationsProjectsDetailConfigurationmatcherarchetype, :t}],
      factions: [{Esi.Api.CorporationsProjectsDetailConfigurationmatcherfaction, :t}],
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
