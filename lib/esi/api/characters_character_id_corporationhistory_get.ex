defmodule Esi.Api.CharactersCharacterIdCorporationhistoryGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdCorporationhistoryGet
  """

  @type t :: %__MODULE__{
          corporation_id: integer,
          is_deleted: boolean | nil,
          record_id: integer,
          start_date: DateTime.t()
        }

  defstruct [:corporation_id, :is_deleted, :record_id, :start_date]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      corporation_id: :integer,
      is_deleted: :boolean,
      record_id: :integer,
      start_date: {:string, :date_time}
    ]
  end
end
