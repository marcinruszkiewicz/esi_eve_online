defmodule Esi.Api.SalvageWreck do
  @moduledoc """
  Provides struct and type for a SalvageWreck
  """

  @type t :: %__MODULE__{
          salvage_wreck: Esi.Api.CorporationsProjectsDetailConfigurationsalvagewreck.t() | nil
        }

  defstruct [:salvage_wreck]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [salvage_wreck: {Esi.Api.CorporationsProjectsDetailConfigurationsalvagewreck, :t}]
  end
end
