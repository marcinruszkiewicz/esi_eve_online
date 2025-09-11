defmodule Esi.Api.UniverseSystemKillsGet do
  @moduledoc """
  Provides struct and type for a UniverseSystemKillsGet
  """

  @type t :: %__MODULE__{
          npc_kills: integer,
          pod_kills: integer,
          ship_kills: integer,
          system_id: integer
        }

  defstruct [:npc_kills, :pod_kills, :ship_kills, :system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [npc_kills: :integer, pod_kills: :integer, ship_kills: :integer, system_id: :integer]
  end
end
