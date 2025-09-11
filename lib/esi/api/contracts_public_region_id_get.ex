defmodule Esi.Api.ContractsPublicRegionIdGet do
  @moduledoc """
  Provides struct and type for a ContractsPublicRegionIdGet
  """

  @type t :: %__MODULE__{
          buyout: number | nil,
          collateral: number | nil,
          contract_id: integer,
          date_expired: DateTime.t(),
          date_issued: DateTime.t(),
          days_to_complete: integer | nil,
          end_location_id: integer | nil,
          for_corporation: boolean | nil,
          issuer_corporation_id: integer,
          issuer_id: integer,
          price: number | nil,
          reward: number | nil,
          start_location_id: integer | nil,
          title: String.t() | nil,
          type: String.t(),
          volume: number | nil
        }

  defstruct [
    :buyout,
    :collateral,
    :contract_id,
    :date_expired,
    :date_issued,
    :days_to_complete,
    :end_location_id,
    :for_corporation,
    :issuer_corporation_id,
    :issuer_id,
    :price,
    :reward,
    :start_location_id,
    :title,
    :type,
    :volume
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      buyout: :number,
      collateral: :number,
      contract_id: :integer,
      date_expired: {:string, :date_time},
      date_issued: {:string, :date_time},
      days_to_complete: :integer,
      end_location_id: :integer,
      for_corporation: :boolean,
      issuer_corporation_id: :integer,
      issuer_id: :integer,
      price: :number,
      reward: :number,
      start_location_id: :integer,
      title: {:string, :generic},
      type: {:enum, ["unknown", "item_exchange", "auction", "courier", "loan"]},
      volume: :number
    ]
  end
end
