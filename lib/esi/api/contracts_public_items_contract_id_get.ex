defmodule Esi.Api.ContractsPublicItemsContractIdGet do
  @moduledoc """
  Provides struct and type for a ContractsPublicItemsContractIdGet
  """

  @type t :: %__MODULE__{
          is_blueprint_copy: boolean | nil,
          is_included: boolean,
          item_id: integer | nil,
          material_efficiency: integer | nil,
          quantity: integer,
          record_id: integer,
          runs: integer | nil,
          time_efficiency: integer | nil,
          type_id: integer
        }

  defstruct [
    :is_blueprint_copy,
    :is_included,
    :item_id,
    :material_efficiency,
    :quantity,
    :record_id,
    :runs,
    :time_efficiency,
    :type_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      is_blueprint_copy: :boolean,
      is_included: :boolean,
      item_id: :integer,
      material_efficiency: :integer,
      quantity: :integer,
      record_id: :integer,
      runs: :integer,
      time_efficiency: :integer,
      type_id: :integer
    ]
  end
end
