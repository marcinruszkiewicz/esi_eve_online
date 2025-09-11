defmodule Esi.Api.CharactersCharacterIdTitlesGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdTitlesGet
  """

  @type t :: %__MODULE__{name: String.t() | nil, title_id: integer | nil}

  defstruct [:name, :title_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: {:string, :generic}, title_id: :integer]
  end
end
