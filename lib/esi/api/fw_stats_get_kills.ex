defmodule Esi.Api.FwStatsGetKills do
  @moduledoc """
  Provides struct and type for a FwStatsGetKills
  """

  @type t :: %__MODULE__{last_week: integer, total: integer, yesterday: integer}

  defstruct [:last_week, :total, :yesterday]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [last_week: :integer, total: :integer, yesterday: :integer]
  end
end
