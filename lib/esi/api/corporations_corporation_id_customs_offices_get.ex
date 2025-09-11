defmodule Esi.Api.CorporationsCorporationIdCustomsOfficesGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdCustomsOfficesGet
  """

  @type t :: %__MODULE__{
          alliance_tax_rate: number | nil,
          allow_access_with_standings: boolean,
          allow_alliance_access: boolean,
          bad_standing_tax_rate: number | nil,
          corporation_tax_rate: number | nil,
          excellent_standing_tax_rate: number | nil,
          good_standing_tax_rate: number | nil,
          neutral_standing_tax_rate: number | nil,
          office_id: integer,
          reinforce_exit_end: integer,
          reinforce_exit_start: integer,
          standing_level: String.t() | nil,
          system_id: integer,
          terrible_standing_tax_rate: number | nil
        }

  defstruct [
    :alliance_tax_rate,
    :allow_access_with_standings,
    :allow_alliance_access,
    :bad_standing_tax_rate,
    :corporation_tax_rate,
    :excellent_standing_tax_rate,
    :good_standing_tax_rate,
    :neutral_standing_tax_rate,
    :office_id,
    :reinforce_exit_end,
    :reinforce_exit_start,
    :standing_level,
    :system_id,
    :terrible_standing_tax_rate
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alliance_tax_rate: :number,
      allow_access_with_standings: :boolean,
      allow_alliance_access: :boolean,
      bad_standing_tax_rate: :number,
      corporation_tax_rate: :number,
      excellent_standing_tax_rate: :number,
      good_standing_tax_rate: :number,
      neutral_standing_tax_rate: :number,
      office_id: :integer,
      reinforce_exit_end: :integer,
      reinforce_exit_start: :integer,
      standing_level: {:enum, ["bad", "excellent", "good", "neutral", "terrible"]},
      system_id: :integer,
      terrible_standing_tax_rate: :number
    ]
  end
end
