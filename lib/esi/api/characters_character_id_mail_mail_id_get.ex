defmodule Esi.Api.CharactersCharacterIdMailMailIdGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMailMailIdGet
  """

  @type t :: %__MODULE__{
          body: String.t() | nil,
          from: integer | nil,
          labels: [integer] | nil,
          read: boolean | nil,
          recipients: [Esi.Api.CharactersCharacterIdMailMailIdGetRecipients.t()] | nil,
          subject: String.t() | nil,
          timestamp: DateTime.t() | nil
        }

  defstruct [:body, :from, :labels, :read, :recipients, :subject, :timestamp]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      body: {:string, :generic},
      from: :integer,
      labels: [:integer],
      read: :boolean,
      recipients: [{Esi.Api.CharactersCharacterIdMailMailIdGetRecipients, :t}],
      subject: {:string, :generic},
      timestamp: {:string, :date_time}
    ]
  end
end
