defmodule Esi.Api.LostShip do
  @moduledoc """
  Provides struct and type for a LostShip
  """

  @type t :: %__MODULE__{
          lost_ship: Esi.Api.CorporationsProjectsDetailConfigurationlostship.t() | nil
        }

  defstruct [:lost_ship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [lost_ship: {Esi.Api.CorporationsProjectsDetailConfigurationlostship, :t}]
  end
end
