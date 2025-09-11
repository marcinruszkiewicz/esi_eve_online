defmodule Esi.Api.CorporationsCorporationIdDivisionsGetWallet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdDivisionsGetWallet
  """

  @type t :: %__MODULE__{division: integer | nil, name: String.t() | nil}

  defstruct [:division, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [division: :integer, name: {:string, :generic}]
  end
end
