defmodule Esi.Api.SolarSystemId do
  @moduledoc """
  Provides struct and types for a SolarSystemId
  """

  @type t :: %__MODULE__{solar_system_id: integer | nil}

  defstruct [:solar_system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [solar_system_id: :integer]
  end
end
