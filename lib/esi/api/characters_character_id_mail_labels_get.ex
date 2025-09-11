defmodule Esi.Api.CharactersCharacterIdMailLabelsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMailLabelsGet
  """

  @type t :: %__MODULE__{
          labels: [Esi.Api.CharactersCharacterIdMailLabelsGetLabels.t()] | nil,
          total_unread_count: integer | nil
        }

  defstruct [:labels, :total_unread_count]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      labels: [{Esi.Api.CharactersCharacterIdMailLabelsGetLabels, :t}],
      total_unread_count: :integer
    ]
  end
end
