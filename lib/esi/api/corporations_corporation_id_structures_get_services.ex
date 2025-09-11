defmodule Esi.Api.CorporationsCorporationIdStructuresGetServices do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdStructuresGetServices
  """

  @type t :: %__MODULE__{name: String.t(), state: String.t()}

  defstruct [:name, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: {:string, :generic}, state: {:enum, ["online", "offline", "cleanup"]}]
  end
end
