defmodule Esi.Api.FleetsFleetIdWingsWingIdSquadsPost do
  @moduledoc """
  Provides struct and type for a FleetsFleetIdWingsWingIdSquadsPost
  """

  @type t :: %__MODULE__{squad_id: integer}

  defstruct [:squad_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [squad_id: :integer]
  end
end
