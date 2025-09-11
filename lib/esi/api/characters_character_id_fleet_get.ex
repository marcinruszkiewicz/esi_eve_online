defmodule Esi.Api.CharactersCharacterIdFleetGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdFleetGet
  """

  @type t :: %__MODULE__{
          fleet_boss_id: integer,
          fleet_id: integer,
          role: String.t(),
          squad_id: integer,
          wing_id: integer
        }

  defstruct [:fleet_boss_id, :fleet_id, :role, :squad_id, :wing_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fleet_boss_id: :integer,
      fleet_id: :integer,
      role: {:enum, ["fleet_commander", "squad_commander", "squad_member", "wing_commander"]},
      squad_id: :integer,
      wing_id: :integer
    ]
  end
end
