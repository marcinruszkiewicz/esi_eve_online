defmodule Esi.Api.CharactersCharacterIdShipGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdShipGet
  """

  @type t :: %__MODULE__{ship_item_id: integer, ship_name: String.t(), ship_type_id: integer}

  defstruct [:ship_item_id, :ship_name, :ship_type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ship_item_id: :integer, ship_name: {:string, :generic}, ship_type_id: :integer]
  end
end
