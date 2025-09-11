defmodule Esi.Api.UniverseSystemsSystemIdGetPlanets do
  @moduledoc """
  Provides struct and type for a UniverseSystemsSystemIdGetPlanets
  """

  @type t :: %__MODULE__{
          asteroid_belts: [integer] | nil,
          moons: [integer] | nil,
          planet_id: integer
        }

  defstruct [:asteroid_belts, :moons, :planet_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [asteroid_belts: [:integer], moons: [:integer], planet_id: :integer]
  end
end
