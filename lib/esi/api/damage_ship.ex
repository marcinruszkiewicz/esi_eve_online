defmodule Esi.Api.DamageShip do
  @moduledoc """
  Provides struct and type for a DamageShip
  """

  @type t :: %__MODULE__{
          damage_ship: Esi.Api.CorporationsProjectsDetailConfigurationdamageship.t() | nil
        }

  defstruct [:damage_ship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [damage_ship: {Esi.Api.CorporationsProjectsDetailConfigurationdamageship, :t}]
  end
end
