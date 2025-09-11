defmodule Esi.Api.CharactersCharacterIdFatigueGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdFatigueGet
  """

  @type t :: %__MODULE__{
          jump_fatigue_expire_date: DateTime.t() | nil,
          last_jump_date: DateTime.t() | nil,
          last_update_date: DateTime.t() | nil
        }

  defstruct [:jump_fatigue_expire_date, :last_jump_date, :last_update_date]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      jump_fatigue_expire_date: {:string, :date_time},
      last_jump_date: {:string, :date_time},
      last_update_date: {:string, :date_time}
    ]
  end
end
