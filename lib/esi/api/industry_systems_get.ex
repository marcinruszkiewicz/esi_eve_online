defmodule Esi.Api.IndustrySystemsGet do
  @moduledoc """
  Provides struct and type for a IndustrySystemsGet
  """

  @type t :: %__MODULE__{
          cost_indices: [Esi.Api.IndustrySystemsGetCostIndices.t()],
          solar_system_id: integer
        }

  defstruct [:cost_indices, :solar_system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cost_indices: [{Esi.Api.IndustrySystemsGetCostIndices, :t}], solar_system_id: :integer]
  end
end
