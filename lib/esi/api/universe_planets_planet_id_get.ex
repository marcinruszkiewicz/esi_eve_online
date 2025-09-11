defmodule Esi.Api.UniversePlanetsPlanetIdGet do
  @moduledoc """
  Provides struct and type for a UniversePlanetsPlanetIdGet
  """

  @type t :: %__MODULE__{
          name: String.t(),
          planet_id: integer,
          position: Esi.Api.UniversePlanetsPlanetIdGetPosition.t(),
          system_id: integer,
          type_id: integer
        }

  defstruct [:name, :planet_id, :position, :system_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      name: {:string, :generic},
      planet_id: :integer,
      position: {Esi.Api.UniversePlanetsPlanetIdGetPosition, :t},
      system_id: :integer,
      type_id: :integer
    ]
  end
end
