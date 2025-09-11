defmodule Esi.Api.CharacterId do
  @moduledoc """
  Provides struct and types for a CharacterId
  """

  @type t :: %__MODULE__{character_id: integer | nil}

  defstruct [:character_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [character_id: :integer]
  end
end
