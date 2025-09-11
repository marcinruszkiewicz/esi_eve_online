defmodule Esi.Api.AlliancesAllianceIdGet do
  @moduledoc """
  Provides struct and type for a AlliancesAllianceIdGet
  """

  @type t :: %__MODULE__{
          creator_corporation_id: integer,
          creator_id: integer,
          date_founded: DateTime.t(),
          executor_corporation_id: integer | nil,
          faction_id: integer | nil,
          name: String.t(),
          ticker: String.t()
        }

  defstruct [
    :creator_corporation_id,
    :creator_id,
    :date_founded,
    :executor_corporation_id,
    :faction_id,
    :name,
    :ticker
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      creator_corporation_id: :integer,
      creator_id: :integer,
      date_founded: {:string, :date_time},
      executor_corporation_id: :integer,
      faction_id: :integer,
      name: {:string, :generic},
      ticker: {:string, :generic}
    ]
  end
end
