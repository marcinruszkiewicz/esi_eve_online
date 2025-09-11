defmodule Esi.Api.IndustrySystemsGetCostIndices do
  @moduledoc """
  Provides struct and type for a IndustrySystemsGetCostIndices
  """

  @type t :: %__MODULE__{activity: String.t(), cost_index: number}

  defstruct [:activity, :cost_index]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activity:
        {:enum,
         [
           "copying",
           "duplicating",
           "invention",
           "manufacturing",
           "none",
           "reaction",
           "researching_material_efficiency",
           "researching_technology",
           "researching_time_efficiency",
           "reverse_engineering"
         ]},
      cost_index: :number
    ]
  end
end
