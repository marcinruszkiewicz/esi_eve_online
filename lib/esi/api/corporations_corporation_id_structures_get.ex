defmodule Esi.Api.CorporationsCorporationIdStructuresGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdStructuresGet
  """

  @type t :: %__MODULE__{
          corporation_id: integer,
          fuel_expires: DateTime.t() | nil,
          name: String.t() | nil,
          next_reinforce_apply: DateTime.t() | nil,
          next_reinforce_hour: integer | nil,
          profile_id: integer,
          reinforce_hour: integer | nil,
          services: [Esi.Api.CorporationsCorporationIdStructuresGetServices.t()] | nil,
          state: String.t(),
          state_timer_end: DateTime.t() | nil,
          state_timer_start: DateTime.t() | nil,
          structure_id: integer,
          system_id: integer,
          type_id: integer,
          unanchors_at: DateTime.t() | nil
        }

  defstruct [
    :corporation_id,
    :fuel_expires,
    :name,
    :next_reinforce_apply,
    :next_reinforce_hour,
    :profile_id,
    :reinforce_hour,
    :services,
    :state,
    :state_timer_end,
    :state_timer_start,
    :structure_id,
    :system_id,
    :type_id,
    :unanchors_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      corporation_id: :integer,
      fuel_expires: {:string, :date_time},
      name: {:string, :generic},
      next_reinforce_apply: {:string, :date_time},
      next_reinforce_hour: :integer,
      profile_id: :integer,
      reinforce_hour: :integer,
      services: [{Esi.Api.CorporationsCorporationIdStructuresGetServices, :t}],
      state:
        {:enum,
         [
           "anchor_vulnerable",
           "anchoring",
           "armor_reinforce",
           "armor_vulnerable",
           "deploy_vulnerable",
           "fitting_invulnerable",
           "hull_reinforce",
           "hull_vulnerable",
           "online_deprecated",
           "onlining_vulnerable",
           "shield_vulnerable",
           "unanchored",
           "unknown"
         ]},
      state_timer_end: {:string, :date_time},
      state_timer_start: {:string, :date_time},
      structure_id: :integer,
      system_id: :integer,
      type_id: :integer,
      unanchors_at: {:string, :date_time}
    ]
  end
end
