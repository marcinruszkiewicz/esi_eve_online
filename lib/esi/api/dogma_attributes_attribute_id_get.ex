defmodule Esi.Api.DogmaAttributesAttributeIdGet do
  @moduledoc """
  Provides struct and type for a DogmaAttributesAttributeIdGet
  """

  @type t :: %__MODULE__{
          attribute_id: integer,
          default_value: number | nil,
          description: String.t() | nil,
          display_name: String.t() | nil,
          high_is_good: boolean | nil,
          icon_id: integer | nil,
          name: String.t() | nil,
          published: boolean | nil,
          stackable: boolean | nil,
          unit_id: integer | nil
        }

  defstruct [
    :attribute_id,
    :default_value,
    :description,
    :display_name,
    :high_is_good,
    :icon_id,
    :name,
    :published,
    :stackable,
    :unit_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attribute_id: :integer,
      default_value: :number,
      description: {:string, :generic},
      display_name: {:string, :generic},
      high_is_good: :boolean,
      icon_id: :integer,
      name: {:string, :generic},
      published: :boolean,
      stackable: :boolean,
      unit_id: :integer
    ]
  end
end
