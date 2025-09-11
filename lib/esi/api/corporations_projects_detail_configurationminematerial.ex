defmodule Esi.Api.CorporationsProjectsDetailConfigurationminematerial do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationminematerial
  """

  @type t :: %__MODULE__{
          locations:
            [Esi.Api.ConstellationId.t() | Esi.Api.RegionId.t() | Esi.Api.SolarSystemId.t()] | nil,
          materials: [Esi.Api.GroupId.t() | Esi.Api.TypeId.t()] | nil
        }

  defstruct [:locations, :materials]

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
      materials: [union: [{Esi.Api.GroupId, :t}, {Esi.Api.TypeId, :t}]]
    ]
  end
end
