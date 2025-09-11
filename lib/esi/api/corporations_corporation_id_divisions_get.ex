defmodule Esi.Api.CorporationsCorporationIdDivisionsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdDivisionsGet
  """

  @type t :: %__MODULE__{
          hangar: [Esi.Api.CorporationsCorporationIdDivisionsGetHangar.t()] | nil,
          wallet: [Esi.Api.CorporationsCorporationIdDivisionsGetWallet.t()] | nil
        }

  defstruct [:hangar, :wallet]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      hangar: [{Esi.Api.CorporationsCorporationIdDivisionsGetHangar, :t}],
      wallet: [{Esi.Api.CorporationsCorporationIdDivisionsGetWallet, :t}]
    ]
  end
end
