defmodule Esi.Api.CorporationsCorporationIdAlliancehistoryGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdAlliancehistoryGet
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          is_deleted: boolean | nil,
          record_id: integer,
          start_date: DateTime.t()
        }

  defstruct [:alliance_id, :is_deleted, :record_id, :start_date]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      is_deleted: :boolean,
      record_id: :integer,
      start_date: {:string, :date_time}
    ]
  end
end
