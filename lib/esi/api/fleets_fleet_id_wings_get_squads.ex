defmodule Esi.Api.FleetsFleetIdWingsGetSquads do
  @moduledoc """
  Provides struct and type for a FleetsFleetIdWingsGetSquads
  """

  @type t :: %__MODULE__{id: integer, name: String.t()}

  defstruct [:id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, name: {:string, :generic}]
  end
end
