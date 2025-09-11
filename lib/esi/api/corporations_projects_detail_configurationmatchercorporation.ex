defmodule Esi.Api.CorporationsProjectsDetailConfigurationmatchercorporation do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationmatchercorporation
  """

  @type t :: %__MODULE__{corporation_id: integer | nil}

  defstruct [:corporation_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [corporation_id: :integer]
  end
end
