defmodule Esi.Api.CorporationsProjectsDetailProgress do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailProgress
  """

  @type t :: %__MODULE__{current: integer, desired: integer}

  defstruct [:current, :desired]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [current: :integer, desired: :integer]
  end
end
