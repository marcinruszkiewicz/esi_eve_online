defmodule Esi.Api.CorporationsProjectsDetailConfigurationearnloyaltypoints do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationearnloyaltypoints
  """

  @type t :: %__MODULE__{
          corporations:
            [Esi.Api.CorporationsProjectsDetailConfigurationmatchercorporation.t()] | nil
        }

  defstruct [:corporations]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [corporations: [{Esi.Api.CorporationsProjectsDetailConfigurationmatchercorporation, :t}]]
  end
end
