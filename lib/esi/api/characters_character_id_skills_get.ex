defmodule Esi.Api.CharactersCharacterIdSkillsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdSkillsGet
  """

  @type t :: %__MODULE__{
          skills: [Esi.Api.CharactersCharacterIdSkillsGetSkills.t()],
          total_sp: integer,
          unallocated_sp: integer | nil
        }

  defstruct [:skills, :total_sp, :unallocated_sp]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      skills: [{Esi.Api.CharactersCharacterIdSkillsGetSkills, :t}],
      total_sp: :integer,
      unallocated_sp: :integer
    ]
  end
end
