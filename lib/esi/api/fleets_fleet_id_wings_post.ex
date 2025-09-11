defmodule Esi.Api.FleetsFleetIdWingsPost do
  @moduledoc """
  Provides struct and type for a FleetsFleetIdWingsPost
  """

  @type t :: %__MODULE__{wing_id: integer}

  defstruct [:wing_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [wing_id: :integer]
  end
end
