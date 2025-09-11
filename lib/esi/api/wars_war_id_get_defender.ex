defmodule Esi.Api.WarsWarIdGetDefender do
  @moduledoc """
  Provides struct and type for a WarsWarIdGetDefender
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          corporation_id: integer | nil,
          isk_destroyed: number,
          ships_killed: integer
        }

  defstruct [:alliance_id, :corporation_id, :isk_destroyed, :ships_killed]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      corporation_id: :integer,
      isk_destroyed: :number,
      ships_killed: :integer
    ]
  end
end
