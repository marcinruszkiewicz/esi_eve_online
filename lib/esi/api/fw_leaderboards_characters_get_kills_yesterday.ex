defmodule Esi.Api.FwLeaderboardsCharactersGetKillsYesterday do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCharactersGetKillsYesterday
  """

  @type t :: %__MODULE__{amount: integer | nil, character_id: integer | nil}

  defstruct [:amount, :character_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [amount: :integer, character_id: :integer]
  end
end
