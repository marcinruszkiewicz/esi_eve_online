defmodule Esi.Api.CorporationsProjectsDetailConfigurationmatcherarchetype do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationmatcherarchetype
  """

  @type t :: %__MODULE__{archetype_id: integer | nil}

  defstruct [:archetype_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [archetype_id: :integer]
  end
end
