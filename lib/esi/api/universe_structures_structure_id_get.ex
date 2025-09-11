defmodule Esi.Api.UniverseStructuresStructureIdGet do
  @moduledoc """
  Provides struct and type for a UniverseStructuresStructureIdGet
  """

  @type t :: %__MODULE__{
          name: String.t(),
          owner_id: integer,
          position: Esi.Api.UniverseStructuresStructureIdGetPosition.t() | nil,
          solar_system_id: integer,
          type_id: integer | nil
        }

  defstruct [:name, :owner_id, :position, :solar_system_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      name: {:string, :generic},
      owner_id: :integer,
      position: {Esi.Api.UniverseStructuresStructureIdGetPosition, :t},
      solar_system_id: :integer,
      type_id: :integer
    ]
  end
end
