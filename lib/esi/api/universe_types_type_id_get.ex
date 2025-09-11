defmodule Esi.Api.UniverseTypesTypeIdGet do
  @moduledoc """
  Provides struct and type for a UniverseTypesTypeIdGet
  """

  @type t :: %__MODULE__{
          capacity: number | nil,
          description: String.t(),
          dogma_attributes: [Esi.Api.UniverseTypesTypeIdGetDogmaAttributes.t()] | nil,
          dogma_effects: [Esi.Api.UniverseTypesTypeIdGetDogmaEffects.t()] | nil,
          graphic_id: integer | nil,
          group_id: integer,
          icon_id: integer | nil,
          market_group_id: integer | nil,
          mass: number | nil,
          name: String.t(),
          packaged_volume: number | nil,
          portion_size: integer | nil,
          published: boolean,
          radius: number | nil,
          type_id: integer,
          volume: number | nil
        }

  defstruct [
    :capacity,
    :description,
    :dogma_attributes,
    :dogma_effects,
    :graphic_id,
    :group_id,
    :icon_id,
    :market_group_id,
    :mass,
    :name,
    :packaged_volume,
    :portion_size,
    :published,
    :radius,
    :type_id,
    :volume
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      capacity: :number,
      description: {:string, :generic},
      dogma_attributes: [{Esi.Api.UniverseTypesTypeIdGetDogmaAttributes, :t}],
      dogma_effects: [{Esi.Api.UniverseTypesTypeIdGetDogmaEffects, :t}],
      graphic_id: :integer,
      group_id: :integer,
      icon_id: :integer,
      market_group_id: :integer,
      mass: :number,
      name: {:string, :generic},
      packaged_volume: :number,
      portion_size: :integer,
      published: :boolean,
      radius: :number,
      type_id: :integer,
      volume: :number
    ]
  end
end
