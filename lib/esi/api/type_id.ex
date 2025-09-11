defmodule Esi.Api.TypeId do
  @moduledoc """
  Provides struct and types for a TypeId
  """

  @type t :: %__MODULE__{type_id: integer | nil}

  defstruct [:type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type_id: :integer]
  end
end
