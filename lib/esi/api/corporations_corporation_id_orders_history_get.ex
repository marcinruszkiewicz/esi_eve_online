defmodule Esi.Api.CorporationsCorporationIdOrdersHistoryGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdOrdersHistoryGet
  """

  @type t :: %__MODULE__{
          duration: integer,
          escrow: number | nil,
          is_buy_order: boolean | nil,
          issued: DateTime.t(),
          issued_by: integer | nil,
          location_id: integer,
          min_volume: integer | nil,
          order_id: integer,
          price: number,
          range: String.t(),
          region_id: integer,
          state: String.t(),
          type_id: integer,
          volume_remain: integer,
          volume_total: integer,
          wallet_division: integer
        }

  defstruct [
    :duration,
    :escrow,
    :is_buy_order,
    :issued,
    :issued_by,
    :location_id,
    :min_volume,
    :order_id,
    :price,
    :range,
    :region_id,
    :state,
    :type_id,
    :volume_remain,
    :volume_total,
    :wallet_division
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      duration: :integer,
      escrow: :number,
      is_buy_order: :boolean,
      issued: {:string, :date_time},
      issued_by: :integer,
      location_id: :integer,
      min_volume: :integer,
      order_id: :integer,
      price: :number,
      range:
        {:enum,
         ["1", "10", "2", "20", "3", "30", "4", "40", "5", "region", "solarsystem", "station"]},
      region_id: :integer,
      state: {:enum, ["cancelled", "expired"]},
      type_id: :integer,
      volume_remain: :integer,
      volume_total: :integer,
      wallet_division: :integer
    ]
  end
end
