defmodule Esi.Api.CharactersCharacterIdClonesGetJumpClones do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdClonesGetJumpClones
  """

  @type t :: %__MODULE__{
          implants: [integer],
          jump_clone_id: integer,
          location_id: integer,
          location_type: String.t(),
          name: String.t() | nil
        }

  defstruct [:implants, :jump_clone_id, :location_id, :location_type, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      implants: [:integer],
      jump_clone_id: :integer,
      location_id: :integer,
      location_type: {:enum, ["station", "structure"]},
      name: {:string, :generic}
    ]
  end
end
