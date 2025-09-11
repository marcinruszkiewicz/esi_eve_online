defmodule Esi.Api.DefendFwComplex do
  @moduledoc """
  Provides struct and type for a DefendFwComplex
  """

  @type t :: %__MODULE__{
          defend_fw_complex:
            Esi.Api.CorporationsProjectsDetailConfigurationdefendfwcomplex.t() | nil
        }

  defstruct [:defend_fw_complex]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [defend_fw_complex: {Esi.Api.CorporationsProjectsDetailConfigurationdefendfwcomplex, :t}]
  end
end
