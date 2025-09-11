defmodule Esi.Api.DestroyShip do
  @moduledoc """
  Provides struct and type for a DestroyShip
  """

  @type t :: %__MODULE__{
          destroy_ship: Esi.Api.CorporationsProjectsDetailConfigurationdestroyship.t() | nil
        }

  defstruct [:destroy_ship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [destroy_ship: {Esi.Api.CorporationsProjectsDetailConfigurationdestroyship, :t}]
  end
end
