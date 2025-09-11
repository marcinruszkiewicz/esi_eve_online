defmodule Esi.Api.AlliancesAllianceIdContactsLabelsGet do
  @moduledoc """
  Provides struct and type for a AlliancesAllianceIdContactsLabelsGet
  """

  @type t :: %__MODULE__{label_id: integer, label_name: String.t()}

  defstruct [:label_id, :label_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [label_id: :integer, label_name: {:string, :generic}]
  end
end
