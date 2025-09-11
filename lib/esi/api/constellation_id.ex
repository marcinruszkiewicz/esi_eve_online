defmodule Esi.Api.ConstellationId do
  @moduledoc """
  Provides struct and types for a ConstellationId
  """

  @type t :: %__MODULE__{constellation_id: integer | nil}

  defstruct [:constellation_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [constellation_id: :integer]
  end
end
