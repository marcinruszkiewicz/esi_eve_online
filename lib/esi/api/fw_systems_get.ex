defmodule Esi.Api.FwSystemsGet do
  @moduledoc """
  Provides struct and type for a FwSystemsGet
  """

  @type t :: %__MODULE__{
          contested: String.t(),
          occupier_faction_id: integer,
          owner_faction_id: integer,
          solar_system_id: integer,
          victory_points: integer,
          victory_points_threshold: integer
        }

  defstruct [
    :contested,
    :occupier_faction_id,
    :owner_faction_id,
    :solar_system_id,
    :victory_points,
    :victory_points_threshold
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contested: {:enum, ["captured", "contested", "uncontested", "vulnerable"]},
      occupier_faction_id: :integer,
      owner_faction_id: :integer,
      solar_system_id: :integer,
      victory_points: :integer,
      victory_points_threshold: :integer
    ]
  end
end
