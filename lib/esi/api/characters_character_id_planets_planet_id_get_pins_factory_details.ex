defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsFactoryDetails do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetPinsFactoryDetails
  """

  @type t :: %__MODULE__{schematic_id: integer}

  defstruct [:schematic_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [schematic_id: :integer]
  end
end
