defmodule Esi.Api.StationId do
  @moduledoc """
  Provides struct and types for a StationId
  """

  @type t :: %__MODULE__{station_id: integer | nil}

  defstruct [:station_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [station_id: :integer]
  end
end
