defmodule Esi.Api.MarketsRegionIdHistoryGet do
  @moduledoc """
  Provides struct and type for a MarketsRegionIdHistoryGet
  """

  @type t :: %__MODULE__{
          average: number,
          date: Date.t(),
          highest: number,
          lowest: number,
          order_count: integer,
          volume: integer
        }

  defstruct [:average, :date, :highest, :lowest, :order_count, :volume]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      average: :number,
      date: {:string, :date},
      highest: :number,
      lowest: :number,
      order_count: :integer,
      volume: :integer
    ]
  end
end
