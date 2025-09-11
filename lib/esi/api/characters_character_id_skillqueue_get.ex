defmodule Esi.Api.CharactersCharacterIdSkillqueueGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdSkillqueueGet
  """

  @type t :: %__MODULE__{
          finish_date: DateTime.t() | nil,
          finished_level: integer,
          level_end_sp: integer | nil,
          level_start_sp: integer | nil,
          queue_position: integer,
          skill_id: integer,
          start_date: DateTime.t() | nil,
          training_start_sp: integer | nil
        }

  defstruct [
    :finish_date,
    :finished_level,
    :level_end_sp,
    :level_start_sp,
    :queue_position,
    :skill_id,
    :start_date,
    :training_start_sp
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      finish_date: {:string, :date_time},
      finished_level: :integer,
      level_end_sp: :integer,
      level_start_sp: :integer,
      queue_position: :integer,
      skill_id: :integer,
      start_date: {:string, :date_time},
      training_start_sp: :integer
    ]
  end
end
