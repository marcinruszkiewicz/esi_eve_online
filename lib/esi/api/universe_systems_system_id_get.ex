defmodule Esi.Api.UniverseSystemsSystemIdGet do
  @moduledoc """
  Provides struct and type for a UniverseSystemsSystemIdGet
  """

  @type t :: %__MODULE__{
          constellation_id: integer,
          name: String.t(),
          planets: [Esi.Api.UniverseSystemsSystemIdGetPlanets.t()] | nil,
          position: Esi.Api.UniverseSystemsSystemIdGetPosition.t(),
          security_class: String.t() | nil,
          security_status: number,
          star_id: integer | nil,
          stargates: [integer] | nil,
          stations: [integer] | nil,
          system_id: integer
        }

  defstruct [
    :constellation_id,
    :name,
    :planets,
    :position,
    :security_class,
    :security_status,
    :star_id,
    :stargates,
    :stations,
    :system_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      constellation_id: :integer,
      name: {:string, :generic},
      planets: [{Esi.Api.UniverseSystemsSystemIdGetPlanets, :t}],
      position: {Esi.Api.UniverseSystemsSystemIdGetPosition, :t},
      security_class: {:string, :generic},
      security_status: :number,
      star_id: :integer,
      stargates: [:integer],
      stations: [:integer],
      system_id: :integer
    ]
  end
end
