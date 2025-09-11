defmodule Esi.Api.CorporationsCorporationIdContractsContractIdBidsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdContractsContractIdBidsGet
  """

  @type t :: %__MODULE__{
          amount: number,
          bid_id: integer,
          bidder_id: integer,
          date_bid: DateTime.t()
        }

  defstruct [:amount, :bid_id, :bidder_id, :date_bid]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [amount: :number, bid_id: :integer, bidder_id: :integer, date_bid: {:string, :date_time}]
  end
end
