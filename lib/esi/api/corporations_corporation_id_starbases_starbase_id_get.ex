defmodule Esi.Api.CorporationsCorporationIdStarbasesStarbaseIdGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdStarbasesStarbaseIdGet
  """

  @type t :: %__MODULE__{
          allow_alliance_members: boolean,
          allow_corporation_members: boolean,
          anchor: String.t(),
          attack_if_at_war: boolean,
          attack_if_other_security_status_dropping: boolean,
          attack_security_status_threshold: number | nil,
          attack_standing_threshold: number | nil,
          fuel_bay_take: String.t(),
          fuel_bay_view: String.t(),
          fuels: [Esi.Api.CorporationsCorporationIdStarbasesStarbaseIdGetFuels.t()] | nil,
          offline: String.t(),
          online: String.t(),
          unanchor: String.t(),
          use_alliance_standings: boolean
        }

  defstruct [
    :allow_alliance_members,
    :allow_corporation_members,
    :anchor,
    :attack_if_at_war,
    :attack_if_other_security_status_dropping,
    :attack_security_status_threshold,
    :attack_standing_threshold,
    :fuel_bay_take,
    :fuel_bay_view,
    :fuels,
    :offline,
    :online,
    :unanchor,
    :use_alliance_standings
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allow_alliance_members: :boolean,
      allow_corporation_members: :boolean,
      anchor:
        {:enum,
         [
           "alliance_member",
           "config_starbase_equipment_role",
           "corporation_member",
           "starbase_fuel_technician_role"
         ]},
      attack_if_at_war: :boolean,
      attack_if_other_security_status_dropping: :boolean,
      attack_security_status_threshold: :number,
      attack_standing_threshold: :number,
      fuel_bay_take:
        {:enum,
         [
           "alliance_member",
           "config_starbase_equipment_role",
           "corporation_member",
           "starbase_fuel_technician_role"
         ]},
      fuel_bay_view:
        {:enum,
         [
           "alliance_member",
           "config_starbase_equipment_role",
           "corporation_member",
           "starbase_fuel_technician_role"
         ]},
      fuels: [{Esi.Api.CorporationsCorporationIdStarbasesStarbaseIdGetFuels, :t}],
      offline:
        {:enum,
         [
           "alliance_member",
           "config_starbase_equipment_role",
           "corporation_member",
           "starbase_fuel_technician_role"
         ]},
      online:
        {:enum,
         [
           "alliance_member",
           "config_starbase_equipment_role",
           "corporation_member",
           "starbase_fuel_technician_role"
         ]},
      unanchor:
        {:enum,
         [
           "alliance_member",
           "config_starbase_equipment_role",
           "corporation_member",
           "starbase_fuel_technician_role"
         ]},
      use_alliance_standings: :boolean
    ]
  end
end
