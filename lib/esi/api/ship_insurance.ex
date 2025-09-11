defmodule Esi.Api.ShipInsurance do
  @moduledoc """
  Provides struct and type for a ShipInsurance
  """

  @type t :: %__MODULE__{
          ship_insurance: Esi.Api.CorporationsProjectsDetailConfigurationshipinsurance.t() | nil
        }

  defstruct [:ship_insurance]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ship_insurance: {Esi.Api.CorporationsProjectsDetailConfigurationshipinsurance, :t}]
  end
end
