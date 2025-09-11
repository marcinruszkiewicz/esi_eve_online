defmodule Esi.Api.IndustryFacilitiesGet do
  @moduledoc """
  Provides struct and type for a IndustryFacilitiesGet
  """

  @type t :: %__MODULE__{
          facility_id: integer,
          owner_id: integer,
          region_id: integer,
          solar_system_id: integer,
          tax: number | nil,
          type_id: integer
        }

  defstruct [:facility_id, :owner_id, :region_id, :solar_system_id, :tax, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      facility_id: :integer,
      owner_id: :integer,
      region_id: :integer,
      solar_system_id: :integer,
      tax: :number,
      type_id: :integer
    ]
  end
end
