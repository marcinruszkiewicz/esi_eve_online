defmodule Esi.Api.CharactersCharacterIdStandingsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdStandingsGet
  """

  @type t :: %__MODULE__{from_id: integer, from_type: String.t(), standing: number}

  defstruct [:from_id, :from_type, :standing]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [from_id: :integer, from_type: {:enum, ["agent", "npc_corp", "faction"]}, standing: :number]
  end
end
