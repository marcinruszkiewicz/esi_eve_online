defmodule Esi.Api.CharactersCharacterIdLocationGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdLocationGet
  """

  @type t :: %__MODULE__{
          solar_system_id: integer,
          station_id: integer | nil,
          structure_id: integer | nil
        }

  defstruct [:solar_system_id, :station_id, :structure_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [solar_system_id: :integer, station_id: :integer, structure_id: :integer]
  end
end
