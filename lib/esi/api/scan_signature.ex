defmodule Esi.Api.ScanSignature do
  @moduledoc """
  Provides struct and type for a ScanSignature
  """

  @type t :: %__MODULE__{
          scan_signature: Esi.Api.CorporationsProjectsDetailConfigurationscansignature.t() | nil
        }

  defstruct [:scan_signature]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [scan_signature: {Esi.Api.CorporationsProjectsDetailConfigurationscansignature, :t}]
  end
end
