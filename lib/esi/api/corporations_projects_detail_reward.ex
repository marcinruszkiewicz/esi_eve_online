defmodule Esi.Api.CorporationsProjectsDetailReward do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailReward
  """

  @type t :: %__MODULE__{initial: number, remaining: number}

  defstruct [:initial, :remaining]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [initial: :number, remaining: :number]
  end
end
