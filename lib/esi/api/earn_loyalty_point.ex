defmodule Esi.Api.EarnLoyaltyPoint do
  @moduledoc """
  Provides struct and type for a EarnLoyaltyPoint
  """

  @type t :: %__MODULE__{
          earn_loyalty_point:
            Esi.Api.CorporationsProjectsDetailConfigurationearnloyaltypoints.t() | nil
        }

  defstruct [:earn_loyalty_point]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [earn_loyalty_point: {Esi.Api.CorporationsProjectsDetailConfigurationearnloyaltypoints, :t}]
  end
end
