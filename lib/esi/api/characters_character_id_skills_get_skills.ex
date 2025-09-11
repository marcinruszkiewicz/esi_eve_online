defmodule Esi.Api.CharactersCharacterIdSkillsGetSkills do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdSkillsGetSkills
  """

  @type t :: %__MODULE__{
          active_skill_level: integer,
          skill_id: integer,
          skillpoints_in_skill: integer,
          trained_skill_level: integer
        }

  defstruct [:active_skill_level, :skill_id, :skillpoints_in_skill, :trained_skill_level]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_skill_level: :integer,
      skill_id: :integer,
      skillpoints_in_skill: :integer,
      trained_skill_level: :integer
    ]
  end
end
