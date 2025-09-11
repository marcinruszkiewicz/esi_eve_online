defmodule Esi.Api.MetaCompatibilityDates do
  @moduledoc """
  Provides struct and type for a MetaCompatibilityDates
  """

  @type t :: %__MODULE__{compatibility_dates: [Date.t()]}

  defstruct [:compatibility_dates]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [compatibility_dates: [string: :date]]
  end
end
