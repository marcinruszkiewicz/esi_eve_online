defmodule Esi.Api.UniverseFactionsGet do
  @moduledoc """
  Provides struct and type for a UniverseFactionsGet
  """

  @type t :: %__MODULE__{
          corporation_id: integer | nil,
          description: String.t(),
          faction_id: integer,
          is_unique: boolean,
          militia_corporation_id: integer | nil,
          name: String.t(),
          size_factor: number,
          solar_system_id: integer | nil,
          station_count: integer,
          station_system_count: integer
        }

  defstruct [
    :corporation_id,
    :description,
    :faction_id,
    :is_unique,
    :militia_corporation_id,
    :name,
    :size_factor,
    :solar_system_id,
    :station_count,
    :station_system_count
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      corporation_id: :integer,
      description: {:string, :generic},
      faction_id: :integer,
      is_unique: :boolean,
      militia_corporation_id: :integer,
      name: {:string, :generic},
      size_factor: :number,
      solar_system_id: :integer,
      station_count: :integer,
      station_system_count: :integer
    ]
  end
end
