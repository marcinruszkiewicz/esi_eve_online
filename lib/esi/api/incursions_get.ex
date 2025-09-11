defmodule Esi.Api.IncursionsGet do
  @moduledoc """
  Provides struct and type for a IncursionsGet
  """

  @type t :: %__MODULE__{
          constellation_id: integer,
          faction_id: integer,
          has_boss: boolean,
          infested_solar_systems: [integer],
          influence: number,
          staging_solar_system_id: integer,
          state: String.t(),
          type: String.t()
        }

  defstruct [
    :constellation_id,
    :faction_id,
    :has_boss,
    :infested_solar_systems,
    :influence,
    :staging_solar_system_id,
    :state,
    :type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      constellation_id: :integer,
      faction_id: :integer,
      has_boss: :boolean,
      infested_solar_systems: [:integer],
      influence: :number,
      staging_solar_system_id: :integer,
      state: {:enum, ["withdrawing", "mobilizing", "established"]},
      type: {:string, :generic}
    ]
  end
end
