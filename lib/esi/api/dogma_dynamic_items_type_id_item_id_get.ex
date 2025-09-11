defmodule Esi.Api.DogmaDynamicItemsTypeIdItemIdGet do
  @moduledoc """
  Provides struct and type for a DogmaDynamicItemsTypeIdItemIdGet
  """

  @type t :: %__MODULE__{
          created_by: integer,
          dogma_attributes: [Esi.Api.DogmaDynamicItemsTypeIdItemIdGetDogmaAttributes.t()],
          dogma_effects: [Esi.Api.DogmaDynamicItemsTypeIdItemIdGetDogmaEffects.t()],
          mutator_type_id: integer,
          source_type_id: integer
        }

  defstruct [:created_by, :dogma_attributes, :dogma_effects, :mutator_type_id, :source_type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_by: :integer,
      dogma_attributes: [{Esi.Api.DogmaDynamicItemsTypeIdItemIdGetDogmaAttributes, :t}],
      dogma_effects: [{Esi.Api.DogmaDynamicItemsTypeIdItemIdGetDogmaEffects, :t}],
      mutator_type_id: :integer,
      source_type_id: :integer
    ]
  end
end
