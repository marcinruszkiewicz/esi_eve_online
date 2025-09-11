defmodule Esi.Api.UniverseRacesGet do
  @moduledoc """
  Provides struct and type for a UniverseRacesGet
  """

  @type t :: %__MODULE__{
          alliance_id: integer,
          description: String.t(),
          name: String.t(),
          race_id: integer
        }

  defstruct [:alliance_id, :description, :name, :race_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      description: {:string, :generic},
      name: {:string, :generic},
      race_id: :integer
    ]
  end
end
