defmodule Esi.Api.CorporationCorporationIdMiningObserversObserverIdGet do
  @moduledoc """
  Provides struct and type for a CorporationCorporationIdMiningObserversObserverIdGet
  """

  @type t :: %__MODULE__{
          character_id: integer,
          last_updated: Date.t(),
          quantity: integer,
          recorded_corporation_id: integer,
          type_id: integer
        }

  defstruct [:character_id, :last_updated, :quantity, :recorded_corporation_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      character_id: :integer,
      last_updated: {:string, :date},
      quantity: :integer,
      recorded_corporation_id: :integer,
      type_id: :integer
    ]
  end
end
