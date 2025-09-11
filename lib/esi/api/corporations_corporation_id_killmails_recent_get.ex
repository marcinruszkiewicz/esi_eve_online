defmodule Esi.Api.CorporationsCorporationIdKillmailsRecentGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdKillmailsRecentGet
  """

  @type t :: %__MODULE__{killmail_hash: String.t(), killmail_id: integer}

  defstruct [:killmail_hash, :killmail_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [killmail_hash: {:string, :generic}, killmail_id: :integer]
  end
end
