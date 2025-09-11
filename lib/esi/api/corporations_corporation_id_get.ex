defmodule Esi.Api.CorporationsCorporationIdGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdGet
  """

  @type t :: %__MODULE__{
          alliance_id: integer | nil,
          ceo_id: integer,
          creator_id: integer,
          date_founded: DateTime.t() | nil,
          description: String.t() | nil,
          faction_id: integer | nil,
          home_station_id: integer | nil,
          member_count: integer,
          name: String.t(),
          shares: integer | nil,
          tax_rate: number,
          ticker: String.t(),
          url: String.t() | nil,
          war_eligible: boolean | nil
        }

  defstruct [
    :alliance_id,
    :ceo_id,
    :creator_id,
    :date_founded,
    :description,
    :faction_id,
    :home_station_id,
    :member_count,
    :name,
    :shares,
    :tax_rate,
    :ticker,
    :url,
    :war_eligible
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_id: :integer,
      ceo_id: :integer,
      creator_id: :integer,
      date_founded: {:string, :date_time},
      description: {:string, :generic},
      faction_id: :integer,
      home_station_id: :integer,
      member_count: :integer,
      name: {:string, :generic},
      shares: :integer,
      tax_rate: :number,
      ticker: {:string, :generic},
      url: {:string, :generic},
      war_eligible: :boolean
    ]
  end
end
