defmodule Esi.Api.InsurancePricesGetLevels do
  @moduledoc """
  Provides struct and type for a InsurancePricesGetLevels
  """

  @type t :: %__MODULE__{cost: number, name: String.t(), payout: number}

  defstruct [:cost, :name, :payout]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cost: :number, name: {:string, :generic}, payout: :number]
  end
end
