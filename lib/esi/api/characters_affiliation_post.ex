defmodule Esi.Api.CharactersAffiliationPost do
  @moduledoc """
  Provides struct and type for a CharactersAffiliationPost
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          character_id: integer,
          corporation_id: integer,
          faction_id: integer | nil
        }

  defstruct [:alliance_id, :character_id, :corporation_id, :faction_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      character_id: :integer,
      corporation_id: :integer,
      faction_id: :integer
    ]
  end
end
