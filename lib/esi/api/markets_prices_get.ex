defmodule Esi.Api.MarketsPricesGet do
  @moduledoc """
  Provides struct and type for a MarketsPricesGet
  """

  @type t :: %__MODULE__{
          adjusted_price: number | nil,
          average_price: number | nil,
          type_id: integer
        }

  defstruct [:adjusted_price, :average_price, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [adjusted_price: :number, average_price: :number, type_id: :integer]
  end
end
