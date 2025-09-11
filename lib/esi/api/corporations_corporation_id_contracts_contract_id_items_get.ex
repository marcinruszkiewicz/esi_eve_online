defmodule Esi.Api.CorporationsCorporationIdContractsContractIdItemsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdContractsContractIdItemsGet
  """

  @type t :: %__MODULE__{
          is_included: boolean,
          is_singleton: boolean,
          quantity: integer,
          raw_quantity: integer | nil,
          record_id: integer,
          type_id: integer
        }

  defstruct [:is_included, :is_singleton, :quantity, :raw_quantity, :record_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      is_included: :boolean,
      is_singleton: :boolean,
      quantity: :integer,
      raw_quantity: :integer,
      record_id: :integer,
      type_id: :integer
    ]
  end
end
