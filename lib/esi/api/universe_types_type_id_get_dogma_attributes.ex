defmodule Esi.Api.UniverseTypesTypeIdGetDogmaAttributes do
  @moduledoc """
  Provides struct and type for a UniverseTypesTypeIdGetDogmaAttributes
  """

  @type t :: %__MODULE__{attribute_id: integer, value: number}

  defstruct [:attribute_id, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [attribute_id: :integer, value: :number]
  end
end
