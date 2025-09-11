defmodule Esi.Api.CharactersCharacterIdClonesGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdClonesGet
  """

  @type t :: %__MODULE__{
          home_location: Esi.Api.CharactersCharacterIdClonesGetHomeLocation.t() | nil,
          jump_clones: [Esi.Api.CharactersCharacterIdClonesGetJumpClones.t()],
          last_clone_jump_date: DateTime.t() | nil,
          last_station_change_date: DateTime.t() | nil
        }

  defstruct [:home_location, :jump_clones, :last_clone_jump_date, :last_station_change_date]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      home_location: {Esi.Api.CharactersCharacterIdClonesGetHomeLocation, :t},
      jump_clones: [{Esi.Api.CharactersCharacterIdClonesGetJumpClones, :t}],
      last_clone_jump_date: {:string, :date_time},
      last_station_change_date: {:string, :date_time}
    ]
  end
end
