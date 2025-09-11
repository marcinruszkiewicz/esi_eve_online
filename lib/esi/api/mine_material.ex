defmodule Esi.Api.MineMaterial do
  @moduledoc """
  Provides struct and type for a MineMaterial
  """

  @type t :: %__MODULE__{
          mine_material: Esi.Api.CorporationsProjectsDetailConfigurationminematerial.t() | nil
        }

  defstruct [:mine_material]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [mine_material: {Esi.Api.CorporationsProjectsDetailConfigurationminematerial, :t}]
  end
end
