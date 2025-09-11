defmodule Esi.Api.CharactersCharacterIdClonesGetHomeLocation do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdClonesGetHomeLocation
  """

  @type t :: %__MODULE__{location_id: integer | nil, location_type: String.t() | nil}

  defstruct [:location_id, :location_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [location_id: :integer, location_type: {:enum, ["station", "structure"]}]
  end
end
