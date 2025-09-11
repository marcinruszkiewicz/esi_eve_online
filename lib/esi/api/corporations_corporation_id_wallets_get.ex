defmodule Esi.Api.CorporationsCorporationIdWalletsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdWalletsGet
  """

  @type t :: %__MODULE__{balance: number, division: integer}

  defstruct [:balance, :division]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [balance: :number, division: :integer]
  end
end
