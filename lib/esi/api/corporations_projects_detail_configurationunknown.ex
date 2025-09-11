defmodule Esi.Api.CorporationsProjectsDetailConfigurationunknown do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationunknown
  """

  @type t :: %__MODULE__{data: map, type: String.t()}

  defstruct [:data, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: :map, type: {:string, :generic}]
  end
end
