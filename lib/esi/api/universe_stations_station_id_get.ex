defmodule Esi.Api.UniverseStationsStationIdGet do
  @moduledoc """
  Provides struct and type for a UniverseStationsStationIdGet
  """

  @type t :: %__MODULE__{
          max_dockable_ship_volume: number,
          name: String.t(),
          office_rental_cost: number,
          owner: integer | nil,
          position: Esi.Api.UniverseStationsStationIdGetPosition.t(),
          race_id: integer | nil,
          reprocessing_efficiency: number,
          reprocessing_stations_take: number,
          services: [String.t()],
          station_id: integer,
          system_id: integer,
          type_id: integer
        }

  defstruct [
    :max_dockable_ship_volume,
    :name,
    :office_rental_cost,
    :owner,
    :position,
    :race_id,
    :reprocessing_efficiency,
    :reprocessing_stations_take,
    :services,
    :station_id,
    :system_id,
    :type_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      max_dockable_ship_volume: :number,
      name: {:string, :generic},
      office_rental_cost: :number,
      owner: :integer,
      position: {Esi.Api.UniverseStationsStationIdGetPosition, :t},
      race_id: :integer,
      reprocessing_efficiency: :number,
      reprocessing_stations_take: :number,
      services: [
        enum: [
          "bounty-missions",
          "assasination-missions",
          "courier-missions",
          "interbus",
          "reprocessing-plant",
          "refinery",
          "market",
          "black-market",
          "stock-exchange",
          "cloning",
          "surgery",
          "dna-therapy",
          "repair-facilities",
          "factory",
          "labratory",
          "gambling",
          "fitting",
          "paintshop",
          "news",
          "storage",
          "insurance",
          "docking",
          "office-rental",
          "jump-clone-facility",
          "loyalty-point-store",
          "navy-offices",
          "security-offices"
        ]
      ],
      station_id: :integer,
      system_id: :integer,
      type_id: :integer
    ]
  end
end
