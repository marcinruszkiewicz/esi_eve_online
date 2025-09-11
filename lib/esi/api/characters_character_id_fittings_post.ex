defmodule Esi.Api.CharactersCharacterIdFittingsPost do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdFittingsPost
  """

  @type t :: %__MODULE__{fitting_id: integer}

  defstruct [:fitting_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fitting_id: :integer]
  end
end
