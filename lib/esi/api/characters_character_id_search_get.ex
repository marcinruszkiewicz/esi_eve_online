defmodule Esi.Api.CharactersCharacterIdSearchGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdSearchGet
  """

  @type t :: %__MODULE__{
          agent: [integer] | nil,
          alliance: [integer] | nil,
          character: [integer] | nil,
          constellation: [integer] | nil,
          corporation: [integer] | nil,
          faction: [integer] | nil,
          inventory_type: [integer] | nil,
          region: [integer] | nil,
          solar_system: [integer] | nil,
          station: [integer] | nil,
          structure: [integer] | nil
        }

  defstruct [
    :agent,
    :alliance,
    :character,
    :constellation,
    :corporation,
    :faction,
    :inventory_type,
    :region,
    :solar_system,
    :station,
    :structure
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent: [:integer],
      alliance: [:integer],
      character: [:integer],
      constellation: [:integer],
      corporation: [:integer],
      faction: [:integer],
      inventory_type: [:integer],
      region: [:integer],
      solar_system: [:integer],
      station: [:integer],
      structure: [:integer]
    ]
  end
end
