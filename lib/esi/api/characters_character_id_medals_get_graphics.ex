defmodule Esi.Api.CharactersCharacterIdMedalsGetGraphics do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMedalsGetGraphics
  """

  @type t :: %__MODULE__{color: integer | nil, graphic: String.t(), layer: integer, part: integer}

  defstruct [:color, :graphic, :layer, :part]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [color: :integer, graphic: {:string, :generic}, layer: :integer, part: :integer]
  end
end
