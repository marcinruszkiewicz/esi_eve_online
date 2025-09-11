defmodule Esi.Api.FactionId do
  @moduledoc """
  Provides struct and types for a FactionId
  """

  @type t :: %__MODULE__{faction_id: integer | nil}

  defstruct [:faction_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [faction_id: :integer]
  end
end
