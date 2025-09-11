defmodule Esi.Api.CorporationsCorporationIdAssetsLocationsPost do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdAssetsLocationsPost
  """

  @type t :: %__MODULE__{
          item_id: integer,
          position: Esi.Api.CorporationsCorporationIdAssetsLocationsPostPosition.t()
        }

  defstruct [:item_id, :position]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      item_id: :integer,
      position: {Esi.Api.CorporationsCorporationIdAssetsLocationsPostPosition, :t}
    ]
  end
end
