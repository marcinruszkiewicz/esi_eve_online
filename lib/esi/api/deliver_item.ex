defmodule Esi.Api.DeliverItem do
  @moduledoc """
  Provides struct and type for a DeliverItem
  """

  @type t :: %__MODULE__{
          deliver_item: Esi.Api.CorporationsProjectsDetailConfigurationdeliveritem.t() | nil
        }

  defstruct [:deliver_item]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [deliver_item: {Esi.Api.CorporationsProjectsDetailConfigurationdeliveritem, :t}]
  end
end
