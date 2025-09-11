defmodule Esi.Api.CorporationsCorporationIdMembersTitlesGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdMembersTitlesGet
  """

  @type t :: %__MODULE__{character_id: integer, titles: [integer]}

  defstruct [:character_id, :titles]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [character_id: :integer, titles: [:integer]]
  end
end
