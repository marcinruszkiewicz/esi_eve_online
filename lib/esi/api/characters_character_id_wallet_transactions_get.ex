defmodule Esi.Api.CharactersCharacterIdWalletTransactionsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdWalletTransactionsGet
  """

  @type t :: %__MODULE__{
          client_id: integer,
          date: DateTime.t(),
          is_buy: boolean,
          is_personal: boolean,
          journal_ref_id: integer,
          location_id: integer,
          quantity: integer,
          transaction_id: integer,
          type_id: integer,
          unit_price: number
        }

  defstruct [
    :client_id,
    :date,
    :is_buy,
    :is_personal,
    :journal_ref_id,
    :location_id,
    :quantity,
    :transaction_id,
    :type_id,
    :unit_price
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      client_id: :integer,
      date: {:string, :date_time},
      is_buy: :boolean,
      is_personal: :boolean,
      journal_ref_id: :integer,
      location_id: :integer,
      quantity: :integer,
      transaction_id: :integer,
      type_id: :integer,
      unit_price: :number
    ]
  end
end
