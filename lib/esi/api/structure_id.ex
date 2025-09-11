defmodule Esi.Api.StructureId do
  @moduledoc """
  Provides struct and types for a StructureId
  """

  @type t :: %__MODULE__{structure_id: integer | nil}

  defstruct [:structure_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [structure_id: :integer]
  end
end
