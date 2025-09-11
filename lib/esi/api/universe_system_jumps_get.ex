defmodule Esi.Api.UniverseSystemJumpsGet do
  @moduledoc """
  Provides struct and type for a UniverseSystemJumpsGet
  """

  @type t :: %__MODULE__{ship_jumps: integer, system_id: integer}

  defstruct [:ship_jumps, :system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ship_jumps: :integer, system_id: :integer]
  end
end
