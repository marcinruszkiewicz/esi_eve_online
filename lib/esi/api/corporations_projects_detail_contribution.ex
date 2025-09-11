defmodule Esi.Api.CorporationsProjectsDetailContribution do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailContribution
  """

  @type t :: %__MODULE__{
          participation_limit: integer | nil,
          reward_per_contribution: number | nil,
          submission_limit: integer | nil,
          submission_multiplier: number | nil
        }

  defstruct [
    :participation_limit,
    :reward_per_contribution,
    :submission_limit,
    :submission_multiplier
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      participation_limit: :integer,
      reward_per_contribution: :number,
      submission_limit: :integer,
      submission_multiplier: :number
    ]
  end
end
