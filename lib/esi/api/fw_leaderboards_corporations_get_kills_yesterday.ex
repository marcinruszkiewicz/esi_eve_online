defmodule Esi.Api.FwLeaderboardsCorporationsGetKillsYesterday do
  @moduledoc """
  Provides struct and type for a FwLeaderboardsCorporationsGetKillsYesterday
  """

  @type t :: %__MODULE__{amount: integer | nil, corporation_id: integer | nil}

  defstruct [:amount, :corporation_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [amount: :integer, corporation_id: :integer]
  end
end
