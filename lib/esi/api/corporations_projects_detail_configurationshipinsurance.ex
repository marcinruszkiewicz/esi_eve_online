defmodule Esi.Api.CorporationsProjectsDetailConfigurationshipinsurance do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationshipinsurance
  """

  @type t :: %__MODULE__{
          conflict_type: String.t(),
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
          reimburse_implants: boolean,
          ships: [Esi.Api.GroupId.t() | Esi.Api.TypeId.t()] | nil
        }

  defstruct [:conflict_type, :identities, :locations, :reimburse_implants, :ships]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conflict_type: {:enum, ["Any", "Pvp", "Pve"]},
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
      reimburse_implants: :boolean,
      ships: [union: [{Esi.Api.GroupId, :t}, {Esi.Api.TypeId, :t}]]
    ]
  end
end
