defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetLinks do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetLinks
  """

  @type t :: %__MODULE__{destination_pin_id: integer, link_level: integer, source_pin_id: integer}

  defstruct [:destination_pin_id, :link_level, :source_pin_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [destination_pin_id: :integer, link_level: :integer, source_pin_id: :integer]
  end
end
