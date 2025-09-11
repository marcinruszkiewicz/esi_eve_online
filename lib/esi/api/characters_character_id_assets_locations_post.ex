defmodule Esi.Api.CharactersCharacterIdAssetsLocationsPost do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdAssetsLocationsPost
  """

  @type t :: %__MODULE__{
          item_id: integer,
          position: Esi.Api.CharactersCharacterIdAssetsLocationsPostPosition.t()
        }

  defstruct [:item_id, :position]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [item_id: :integer, position: {Esi.Api.CharactersCharacterIdAssetsLocationsPostPosition, :t}]
  end
end
