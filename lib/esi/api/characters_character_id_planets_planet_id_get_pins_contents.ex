defmodule Esi.Api.CharactersCharacterIdPlanetsPlanetIdGetPinsContents do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdPlanetsPlanetIdGetPinsContents
  """

  @type t :: %__MODULE__{amount: integer, type_id: integer}

  defstruct [:amount, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [amount: :integer, type_id: :integer]
  end
end
