defmodule Esi.Api.CharactersCharacterIdBlueprintsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdBlueprintsGet
  """

  @type t :: %__MODULE__{
          item_id: integer,
          location_flag: String.t(),
          location_id: integer,
          material_efficiency: integer,
          quantity: integer,
          runs: integer,
          time_efficiency: integer,
          type_id: integer
        }

  defstruct [
    :item_id,
    :location_flag,
    :location_id,
    :material_efficiency,
    :quantity,
    :runs,
    :time_efficiency,
    :type_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      item_id: :integer,
      location_flag:
        {:enum,
         [
           "AutoFit",
           "Cargo",
           "CorpseBay",
           "DroneBay",
           "FleetHangar",
           "Deliveries",
           "HiddenModifiers",
           "Hangar",
           "HangarAll",
           "LoSlot0",
           "LoSlot1",
           "LoSlot2",
           "LoSlot3",
           "LoSlot4",
           "LoSlot5",
           "LoSlot6",
           "LoSlot7",
           "MedSlot0",
           "MedSlot1",
           "MedSlot2",
           "MedSlot3",
           "MedSlot4",
           "MedSlot5",
           "MedSlot6",
           "MedSlot7",
           "HiSlot0",
           "HiSlot1",
           "HiSlot2",
           "HiSlot3",
           "HiSlot4",
           "HiSlot5",
           "HiSlot6",
           "HiSlot7",
           "AssetSafety",
           "Locked",
           "Unlocked",
           "Implant",
           "QuafeBay",
           "RigSlot0",
           "RigSlot1",
           "RigSlot2",
           "RigSlot3",
           "RigSlot4",
           "RigSlot5",
           "RigSlot6",
           "RigSlot7",
           "ShipHangar",
           "SpecializedFuelBay",
           "SpecializedOreHold",
           "SpecializedGasHold",
           "SpecializedMineralHold",
           "SpecializedSalvageHold",
           "SpecializedShipHold",
           "SpecializedSmallShipHold",
           "SpecializedMediumShipHold",
           "SpecializedLargeShipHold",
           "SpecializedIndustrialShipHold",
           "SpecializedAmmoHold",
           "SpecializedCommandCenterHold",
           "SpecializedPlanetaryCommoditiesHold",
           "SpecializedMaterialBay",
           "SubSystemSlot0",
           "SubSystemSlot1",
           "SubSystemSlot2",
           "SubSystemSlot3",
           "SubSystemSlot4",
           "SubSystemSlot5",
           "SubSystemSlot6",
           "SubSystemSlot7",
           "FighterBay",
           "FighterTube0",
           "FighterTube1",
           "FighterTube2",
           "FighterTube3",
           "FighterTube4",
           "Module"
         ]},
      location_id: :integer,
      material_efficiency: :integer,
      quantity: :integer,
      runs: :integer,
      time_efficiency: :integer,
      type_id: :integer
    ]
  end
end
