defmodule Esi.Api.CharactersCharacterIdMailListsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMailListsGet
  """

  @type t :: %__MODULE__{mailing_list_id: integer, name: String.t()}

  defstruct [:mailing_list_id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [mailing_list_id: :integer, name: {:string, :generic}]
  end
end
