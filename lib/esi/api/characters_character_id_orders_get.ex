defmodule Esi.Api.CharactersCharacterIdOrdersGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdOrdersGet
  """

  @type t :: %__MODULE__{
          duration: integer,
          escrow: number | nil,
          is_buy_order: boolean | nil,
          is_corporation: boolean,
          issued: DateTime.t(),
          location_id: integer,
          min_volume: integer | nil,
          order_id: integer,
          price: number,
          range: String.t(),
          region_id: integer,
          type_id: integer,
          volume_remain: integer,
          volume_total: integer
        }

  defstruct [
    :duration,
    :escrow,
    :is_buy_order,
    :is_corporation,
    :issued,
    :location_id,
    :min_volume,
    :order_id,
    :price,
    :range,
    :region_id,
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
      escrow: :number,
      is_buy_order: :boolean,
      is_corporation: :boolean,
      issued: {:string, :date_time},
      location_id: :integer,
      min_volume: :integer,
      order_id: :integer,
      price: :number,
      range:
        {:enum,
         ["1", "10", "2", "20", "3", "30", "4", "40", "5", "region", "solarsystem", "station"]},
      region_id: :integer,
      type_id: :integer,
      volume_remain: :integer,
      volume_total: :integer
    ]
  end
end
