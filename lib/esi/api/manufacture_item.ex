defmodule Esi.Api.ManufactureItem do
  @moduledoc """
  Provides struct and type for a ManufactureItem
  """

  @type t :: %__MODULE__{
          manufacture_item:
            Esi.Api.CorporationsProjectsDetailConfigurationmanufactureitem.t() | nil
        }

  defstruct [:manufacture_item]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [manufacture_item: {Esi.Api.CorporationsProjectsDetailConfigurationmanufactureitem, :t}]
  end
end
