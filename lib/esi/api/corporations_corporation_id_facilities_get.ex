defmodule Esi.Api.CorporationsCorporationIdFacilitiesGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdFacilitiesGet
  """

  @type t :: %__MODULE__{facility_id: integer, system_id: integer, type_id: integer}

  defstruct [:facility_id, :system_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [facility_id: :integer, system_id: :integer, type_id: :integer]
  end
end
