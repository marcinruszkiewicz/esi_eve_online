defmodule Esi.Api.CharactersCharacterIdFittingsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdFittingsGet
  """

  @type t :: %__MODULE__{
          description: String.t(),
          fitting_id: integer,
          items: [Esi.Api.CharactersCharacterIdFittingsGetItems.t()],
          name: String.t(),
          ship_type_id: integer
        }

  defstruct [:description, :fitting_id, :items, :name, :ship_type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      fitting_id: :integer,
      items: [{Esi.Api.CharactersCharacterIdFittingsGetItems, :t}],
      name: {:string, :generic},
      ship_type_id: :integer
    ]
  end
end
