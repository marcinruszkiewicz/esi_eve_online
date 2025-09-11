defmodule Esi.Api.CorporationsCorporationIdAssetsNamesPost do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdAssetsNamesPost
  """

  @type t :: %__MODULE__{item_id: integer, name: String.t()}

  defstruct [:item_id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [item_id: :integer, name: {:string, :generic}]
  end
end
