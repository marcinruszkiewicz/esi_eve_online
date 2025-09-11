defmodule Esi.Api.CorporationsCorporationIdMembertrackingGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdMembertrackingGet
  """

  @type t :: %__MODULE__{
          base_id: integer | nil,
          character_id: integer,
          location_id: integer | nil,
          logoff_date: DateTime.t() | nil,
          logon_date: DateTime.t() | nil,
          ship_type_id: integer | nil,
          start_date: DateTime.t() | nil
        }

  defstruct [
    :base_id,
    :character_id,
    :location_id,
    :logoff_date,
    :logon_date,
    :ship_type_id,
    :start_date
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      base_id: :integer,
      character_id: :integer,
      location_id: :integer,
      logoff_date: {:string, :date_time},
      logon_date: {:string, :date_time},
      ship_type_id: :integer,
      start_date: {:string, :date_time}
    ]
  end
end
