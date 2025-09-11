defmodule Esi.Api.UniverseAsteroidBeltsAsteroidBeltIdGet do
  @moduledoc """
  Provides struct and type for a UniverseAsteroidBeltsAsteroidBeltIdGet
  """

  @type t :: %__MODULE__{
          name: String.t(),
          position: Esi.Api.UniverseAsteroidBeltsAsteroidBeltIdGetPosition.t(),
          system_id: integer
        }

  defstruct [:name, :position, :system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      name: {:string, :generic},
      position: {Esi.Api.UniverseAsteroidBeltsAsteroidBeltIdGetPosition, :t},
      system_id: :integer
    ]
  end
end
