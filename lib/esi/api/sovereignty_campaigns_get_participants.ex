defmodule Esi.Api.SovereigntyCampaignsGetParticipants do
  @moduledoc """
  Provides struct and type for a SovereigntyCampaignsGetParticipants
  """

  @type t :: %__MODULE__{alliance_id: integer, score: number}

  defstruct [:alliance_id, :score]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [alliance_id: :integer, score: :number]
  end
end
