defmodule Esi.Api.RegionId do
  @moduledoc """
  Provides struct and types for a RegionId
  """

  @type t :: %__MODULE__{region_id: integer | nil}

  defstruct [:region_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [region_id: :integer]
  end
end
