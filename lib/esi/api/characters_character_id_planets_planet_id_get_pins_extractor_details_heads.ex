defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetailsHeads do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetPinsExtractorDetailsHeads
  """

  @type t :: %__MODULE__{head_id: integer, latitude: number, longitude: number}

  defstruct [:head_id, :latitude, :longitude]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [head_id: :integer, latitude: :number, longitude: :number]
  end
end
