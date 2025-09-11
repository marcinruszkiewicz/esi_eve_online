defmodule Esi.Api.MarketsRegionIdOrdersGet do
  @moduledoc """
  Provides struct and type for a MarketsRegionIdOrdersGet
  """

  @type t :: %__MODULE__{
          duration: integer,
          is_buy_order: boolean,
          issued: DateTime.t(),
          location_id: integer,
          min_volume: integer,
          order_id: integer,
          price: number,
          range: String.t(),
          system_id: integer,
          type_id: integer,
          volume_remain: integer,
          volume_total: integer
        }

  defstruct [
    :duration,
    :is_buy_order,
    :issued,
    :location_id,
    :min_volume,
    :order_id,
    :price,
    :range,
    :system_id,
    :type_id,
    :volume_remain,
    :volume_total
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      duration: :integer,
      is_buy_order: :boolean,
      issued: {:string, :date_time},
      location_id: :integer,
      min_volume: :integer,
      order_id: :integer,
      price: :number,
      range:
        {:enum,
         ["station", "region", "solarsystem", "1", "2", "3", "4", "5", "10", "20", "30", "40"]},
      system_id: :integer,
      type_id: :integer,
      volume_remain: :integer,
      volume_total: :integer
    ]
  end
end
