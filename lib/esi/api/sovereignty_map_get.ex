defmodule Esi.Api.SovereigntyMapGet do
  @moduledoc """
  Provides struct and type for a SovereigntyMapGet
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          corporation_id: integer | nil,
          faction_id: integer | nil,
          system_id: integer
        }

  defstruct [:alliance_id, :corporation_id, :faction_id, :system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [alliance_id: :integer, corporation_id: :integer, faction_id: :integer, system_id: :integer]
  end
end
