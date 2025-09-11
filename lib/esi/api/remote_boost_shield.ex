defmodule Esi.Api.RemoteBoostShield do
  @moduledoc """
  Provides struct and type for a RemoteBoostShield
  """

  @type t :: %__MODULE__{
          remote_boost_shield:
            Esi.Api.CorporationsProjectsDetailConfigurationremoteboostshield.t() | nil
        }

  defstruct [:remote_boost_shield]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [remote_boost_shield: {Esi.Api.CorporationsProjectsDetailConfigurationremoteboostshield, :t}]
  end
end
