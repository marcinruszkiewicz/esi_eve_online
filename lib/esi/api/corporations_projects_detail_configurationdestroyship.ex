defmodule Esi.Api.CorporationsProjectsDetailConfigurationdestroyship do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationdestroyship
  """

  @type t :: %__MODULE__{
          identities:
            [
              Esi.Api.AllianceId.t()
              | Esi.Api.CharacterId.t()
              | Esi.Api.CorporationId.t()
              | Esi.Api.FactionId.t()
            ]
            | nil,
          locations:
            [Esi.Api.ConstellationId.t() | Esi.Api.RegionId.t() | Esi.Api.SolarSystemId.t()] | nil,
          ships: [Esi.Api.GroupId.t() | Esi.Api.TypeId.t()] | nil
        }

  defstruct [:identities, :locations, :ships]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      identities: [
        union: [
          {Esi.Api.AllianceId, :t},
          {Esi.Api.CharacterId, :t},
          {Esi.Api.CorporationId, :t},
          {Esi.Api.FactionId, :t}
        ]
      ],
      locations: [
        union: [
          {Esi.Api.ConstellationId, :t},
          {Esi.Api.RegionId, :t},
          {Esi.Api.SolarSystemId, :t}
        ]
      ],
      ships: [union: [{Esi.Api.GroupId, :t}, {Esi.Api.TypeId, :t}]]
    ]
  end
end
