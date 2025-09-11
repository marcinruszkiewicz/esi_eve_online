defmodule Esi.Api.DestroyNpc do
  @moduledoc """
  Provides struct and type for a DestroyNpc
  """

  @type t :: %__MODULE__{
          destroy_npc: Esi.Api.CorporationsProjectsDetailConfigurationdestroynpc.t() | nil
        }

  defstruct [:destroy_npc]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [destroy_npc: {Esi.Api.CorporationsProjectsDetailConfigurationdestroynpc, :t}]
  end
end
