defmodule Esi.Api.UniverseAsteroidBeltsAsteroidBeltIdGetPosition do
  @moduledoc """
  Provides struct and type for a UniverseAsteroidBeltsAsteroidBeltIdGetPosition
  """

  @type t :: %__MODULE__{x: number, y: number, z: number}

  defstruct [:x, :y, :z]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [x: :number, y: :number, z: :number]
  end
end
