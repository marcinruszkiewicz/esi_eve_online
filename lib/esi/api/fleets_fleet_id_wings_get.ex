defmodule Esi.Api.FleetsFleetIdWingsGet do
  @moduledoc """
  Provides struct and type for a FleetsFleetIdWingsGet
  """

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          squads: [Esi.Api.FleetsFleetIdWingsGetSquads.t()]
        }

  defstruct [:id, :name, :squads]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, name: {:string, :generic}, squads: [{Esi.Api.FleetsFleetIdWingsGetSquads, :t}]]
  end
end
