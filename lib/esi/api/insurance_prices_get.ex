defmodule Esi.Api.InsurancePricesGet do
  @moduledoc """
  Provides struct and type for a InsurancePricesGet
  """

  @type t :: %__MODULE__{levels: [Esi.Api.InsurancePricesGetLevels.t()], type_id: integer}

  defstruct [:levels, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [levels: [{Esi.Api.InsurancePricesGetLevels, :t}], type_id: :integer]
  end
end
