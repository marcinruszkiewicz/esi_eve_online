defmodule Esi.Api.CaptureFwComplex do
  @moduledoc """
  Provides struct and type for a CaptureFwComplex
  """

  @type t :: %__MODULE__{
          capture_fw_complex:
            Esi.Api.CorporationsProjectsDetailConfigurationcapturefwcomplex.t() | nil
        }

  defstruct [:capture_fw_complex]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [capture_fw_complex: {Esi.Api.CorporationsProjectsDetailConfigurationcapturefwcomplex, :t}]
  end
end
