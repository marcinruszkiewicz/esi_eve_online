defmodule Esi.Api.CorporationsProjectsContribution do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsContribution
  """

  @type t :: %__MODULE__{contributed: integer, last_modified: DateTime.t() | nil}

  defstruct [:contributed, :last_modified]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contributed: :integer, last_modified: {:string, :date_time}]
  end
end
