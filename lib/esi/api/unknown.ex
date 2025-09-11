defmodule Esi.Api.Unknown do
  @moduledoc """
  Provides struct and type for a Unknown
  """

  @type t :: %__MODULE__{
          unknown: Esi.Api.CorporationsProjectsDetailConfigurationunknown.t() | nil
        }

  defstruct [:unknown]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [unknown: {Esi.Api.CorporationsProjectsDetailConfigurationunknown, :t}]
  end
end
