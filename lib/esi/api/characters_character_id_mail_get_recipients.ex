defmodule Esi.Api.CharactersCharacterIdMailGetRecipients do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMailGetRecipients
  """

  @type t :: %__MODULE__{recipient_id: integer, recipient_type: String.t()}

  defstruct [:recipient_id, :recipient_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      recipient_id: :integer,
      recipient_type: {:enum, ["alliance", "character", "corporation", "mailing_list"]}
    ]
  end
end
