defmodule Esi.Api.UniverseNamesPost do
  @moduledoc """
  Provides struct and type for a UniverseNamesPost
  """

  @type t :: %__MODULE__{category: String.t(), id: integer, name: String.t()}

  defstruct [:category, :id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      category:
        {:enum,
         [
           "alliance",
           "character",
           "constellation",
           "corporation",
           "inventory_type",
           "region",
           "solar_system",
           "station",
           "faction"
         ]},
      id: :integer,
      name: {:string, :generic}
    ]
  end
end
