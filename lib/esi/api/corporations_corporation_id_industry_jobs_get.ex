defmodule Esi.Api.CorporationsCorporationIdIndustryJobsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdIndustryJobsGet
  """

  @type t :: %__MODULE__{
          activity_id: integer,
          blueprint_id: integer,
          blueprint_location_id: integer,
          blueprint_type_id: integer,
          completed_character_id: integer | nil,
          completed_date: DateTime.t() | nil,
          cost: number | nil,
          duration: integer,
          end_date: DateTime.t(),
          facility_id: integer,
          installer_id: integer,
          job_id: integer,
          licensed_runs: integer | nil,
          location_id: integer,
          output_location_id: integer,
          pause_date: DateTime.t() | nil,
          probability: number | nil,
          product_type_id: integer | nil,
          runs: integer,
          start_date: DateTime.t(),
          status: String.t(),
          successful_runs: integer | nil
        }

  defstruct [
    :activity_id,
    :blueprint_id,
    :blueprint_location_id,
    :blueprint_type_id,
    :completed_character_id,
    :completed_date,
    :cost,
    :duration,
    :end_date,
    :facility_id,
    :installer_id,
    :job_id,
    :licensed_runs,
    :location_id,
    :output_location_id,
    :pause_date,
    :probability,
    :product_type_id,
    :runs,
    :start_date,
    :status,
    :successful_runs
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activity_id: :integer,
      blueprint_id: :integer,
      blueprint_location_id: :integer,
      blueprint_type_id: :integer,
      completed_character_id: :integer,
      completed_date: {:string, :date_time},
      cost: :number,
      duration: :integer,
      end_date: {:string, :date_time},
      facility_id: :integer,
      installer_id: :integer,
      job_id: :integer,
      licensed_runs: :integer,
      location_id: :integer,
      output_location_id: :integer,
      pause_date: {:string, :date_time},
      probability: :number,
      product_type_id: :integer,
      runs: :integer,
      start_date: {:string, :date_time},
      status: {:enum, ["active", "cancelled", "delivered", "paused", "ready", "reverted"]},
      successful_runs: :integer
    ]
  end
end
