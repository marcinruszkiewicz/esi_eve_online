defmodule Esi.Api.UniverseSchematicsSchematicIdGet do
  @moduledoc """
  Provides struct and type for a UniverseSchematicsSchematicIdGet
  """

  @type t :: %__MODULE__{cycle_time: integer, schematic_name: String.t()}

  defstruct [:cycle_time, :schematic_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cycle_time: :integer, schematic_name: {:string, :generic}]
  end
end
