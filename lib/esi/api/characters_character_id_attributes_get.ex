defmodule Esi.Api.CharactersCharacterIdAttributesGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdAttributesGet
  """

  @type t :: %__MODULE__{
          accrued_remap_cooldown_date: DateTime.t() | nil,
          bonus_remaps: integer | nil,
          charisma: integer,
          intelligence: integer,
          last_remap_date: DateTime.t() | nil,
          memory: integer,
          perception: integer,
          willpower: integer
        }

  defstruct [
    :accrued_remap_cooldown_date,
    :bonus_remaps,
    :charisma,
    :intelligence,
    :last_remap_date,
    :memory,
    :perception,
    :willpower
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accrued_remap_cooldown_date: {:string, :date_time},
      bonus_remaps: :integer,
      charisma: :integer,
      intelligence: :integer,
      last_remap_date: {:string, :date_time},
      memory: :integer,
      perception: :integer,
      willpower: :integer
    ]
  end
end
