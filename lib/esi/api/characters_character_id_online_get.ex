defmodule Esi.Api.CharactersCharacterIdOnlineGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdOnlineGet
  """

  @type t :: %__MODULE__{
          last_login: DateTime.t() | nil,
          last_logout: DateTime.t() | nil,
          logins: integer | nil,
          online: boolean
        }

  defstruct [:last_login, :last_logout, :logins, :online]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      last_login: {:string, :date_time},
      last_logout: {:string, :date_time},
      logins: :integer,
      online: :boolean
    ]
  end
end
