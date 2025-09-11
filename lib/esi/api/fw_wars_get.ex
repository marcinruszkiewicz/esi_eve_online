defmodule Esi.Api.FwWarsGet do
  @moduledoc """
  Provides struct and type for a FwWarsGet
  """

  @type t :: %__MODULE__{against_id: integer, faction_id: integer}

  defstruct [:against_id, :faction_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [against_id: :integer, faction_id: :integer]
  end
end
