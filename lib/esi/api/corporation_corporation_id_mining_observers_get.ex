defmodule Esi.Api.CorporationCorporationIdMiningObserversGet do
  @moduledoc """
  Provides struct and type for a CorporationCorporationIdMiningObserversGet
  """

  @type t :: %__MODULE__{last_updated: Date.t(), observer_id: integer, observer_type: String.t()}

  defstruct [:last_updated, :observer_id, :observer_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [last_updated: {:string, :date}, observer_id: :integer, observer_type: {:const, "structure"}]
  end
end
