defmodule Esi.Api.UniverseTypesTypeIdGetDogmaEffects do
  @moduledoc """
  Provides struct and type for a UniverseTypesTypeIdGetDogmaEffects
  """

  @type t :: %__MODULE__{effect_id: integer, is_default: boolean}

  defstruct [:effect_id, :is_default]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [effect_id: :integer, is_default: :boolean]
  end
end
