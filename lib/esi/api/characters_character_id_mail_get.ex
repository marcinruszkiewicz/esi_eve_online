defmodule Esi.Api.CharactersCharacterIdMailGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMailGet
  """

  @type t :: %__MODULE__{
          from: integer | nil,
          is_read: boolean | nil,
          labels: [integer] | nil,
          mail_id: integer | nil,
          recipients: [Esi.Api.CharactersCharacterIdMailGetRecipients.t()] | nil,
          subject: String.t() | nil,
          timestamp: DateTime.t() | nil
        }

  defstruct [:from, :is_read, :labels, :mail_id, :recipients, :subject, :timestamp]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      from: :integer,
      is_read: :boolean,
      labels: [:integer],
      mail_id: :integer,
      recipients: [{Esi.Api.CharactersCharacterIdMailGetRecipients, :t}],
      subject: {:string, :generic},
      timestamp: {:string, :date_time}
    ]
  end
end
