defmodule Esi.Api.SovereigntyStructuresGet do
  @moduledoc """
  Provides struct and type for a SovereigntyStructuresGet
  """

  @type t :: %__MODULE__{
          alliance_id: integer,
          solar_system_id: integer,
          structure_id: integer,
          structure_type_id: integer,
          vulnerability_occupancy_level: number | nil,
          vulnerable_end_time: DateTime.t() | nil,
          vulnerable_start_time: DateTime.t() | nil
        }

  defstruct [
    :alliance_id,
    :solar_system_id,
    :structure_id,
    :structure_type_id,
    :vulnerability_occupancy_level,
    :vulnerable_end_time,
    :vulnerable_start_time
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      solar_system_id: :integer,
      structure_id: :integer,
      structure_type_id: :integer,
      vulnerability_occupancy_level: :number,
      vulnerable_end_time: {:string, :date_time},
      vulnerable_start_time: {:string, :date_time}
    ]
  end
end
