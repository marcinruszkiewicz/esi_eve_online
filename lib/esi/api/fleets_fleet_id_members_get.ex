defmodule Esi.Api.FleetsFleetIdMembersGet do
  @moduledoc """
  Provides struct and type for a FleetsFleetIdMembersGet
  """

  @type t :: %__MODULE__{
          character_id: integer,
          join_time: DateTime.t(),
          role: String.t(),
          role_name: String.t(),
          ship_type_id: integer,
          solar_system_id: integer,
          squad_id: integer,
          station_id: integer | nil,
          takes_fleet_warp: boolean,
          wing_id: integer
        }

  defstruct [
    :character_id,
    :join_time,
    :role,
    :role_name,
    :ship_type_id,
    :solar_system_id,
    :squad_id,
    :station_id,
    :takes_fleet_warp,
    :wing_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      character_id: :integer,
      join_time: {:string, :date_time},
      role: {:enum, ["fleet_commander", "wing_commander", "squad_commander", "squad_member"]},
      role_name: {:string, :generic},
      ship_type_id: :integer,
      solar_system_id: :integer,
      squad_id: :integer,
      station_id: :integer,
      takes_fleet_warp: :boolean,
      wing_id: :integer
    ]
  end
end
