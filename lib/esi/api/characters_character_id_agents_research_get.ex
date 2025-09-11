defmodule Esi.Api.CharactersCharacterIdAgentsResearchGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdAgentsResearchGet
  """

  @type t :: %__MODULE__{
          agent_id: integer,
          points_per_day: number,
          remainder_points: number,
          skill_type_id: integer,
          started_at: DateTime.t()
        }

  defstruct [:agent_id, :points_per_day, :remainder_points, :skill_type_id, :started_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :integer,
      points_per_day: :number,
      remainder_points: :number,
      skill_type_id: :integer,
      started_at: {:string, :date_time}
    ]
  end
end
