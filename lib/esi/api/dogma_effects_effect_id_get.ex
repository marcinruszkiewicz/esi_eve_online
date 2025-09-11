defmodule Esi.Api.DogmaEffectsEffectIdGet do
  @moduledoc """
  Provides struct and type for a DogmaEffectsEffectIdGet
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          disallow_auto_repeat: boolean | nil,
          discharge_attribute_id: integer | nil,
          display_name: String.t() | nil,
          duration_attribute_id: integer | nil,
          effect_category: integer | nil,
          effect_id: integer,
          electronic_chance: boolean | nil,
          falloff_attribute_id: integer | nil,
          icon_id: integer | nil,
          is_assistance: boolean | nil,
          is_offensive: boolean | nil,
          is_warp_safe: boolean | nil,
          modifiers: [Esi.Api.DogmaEffectsEffectIdGetModifiers.t()] | nil,
          name: String.t() | nil,
          post_expression: integer | nil,
          pre_expression: integer | nil,
          published: boolean | nil,
          range_attribute_id: integer | nil,
          range_chance: boolean | nil,
          tracking_speed_attribute_id: integer | nil
        }

  defstruct [
    :description,
    :disallow_auto_repeat,
    :discharge_attribute_id,
    :display_name,
    :duration_attribute_id,
    :effect_category,
    :effect_id,
    :electronic_chance,
    :falloff_attribute_id,
    :icon_id,
    :is_assistance,
    :is_offensive,
    :is_warp_safe,
    :modifiers,
    :name,
    :post_expression,
    :pre_expression,
    :published,
    :range_attribute_id,
    :range_chance,
    :tracking_speed_attribute_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      disallow_auto_repeat: :boolean,
      discharge_attribute_id: :integer,
      display_name: {:string, :generic},
      duration_attribute_id: :integer,
      effect_category: :integer,
      effect_id: :integer,
      electronic_chance: :boolean,
      falloff_attribute_id: :integer,
      icon_id: :integer,
      is_assistance: :boolean,
      is_offensive: :boolean,
      is_warp_safe: :boolean,
      modifiers: [{Esi.Api.DogmaEffectsEffectIdGetModifiers, :t}],
      name: {:string, :generic},
      post_expression: :integer,
      pre_expression: :integer,
      published: :boolean,
      range_attribute_id: :integer,
      range_chance: :boolean,
      tracking_speed_attribute_id: :integer
    ]
  end
end
