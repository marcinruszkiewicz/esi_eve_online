defmodule Esi.Api.CorporationsCorporationIdIconsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdIconsGet
  """

  @type t :: %__MODULE__{
          px128x128: String.t() | nil,
          px256x256: String.t() | nil,
          px64x64: String.t() | nil
        }

  defstruct [:px128x128, :px256x256, :px64x64]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [px128x128: {:string, :generic}, px256x256: {:string, :generic}, px64x64: {:string, :generic}]
  end
end
