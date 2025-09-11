defmodule Esi.Api.UniverseStargatesStargateIdGetDestination do
  @moduledoc """
  Provides struct and type for a UniverseStargatesStargateIdGetDestination
  """

  @type t :: %__MODULE__{stargate_id: integer, system_id: integer}

  defstruct [:stargate_id, :system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [stargate_id: :integer, system_id: :integer]
  end
end
