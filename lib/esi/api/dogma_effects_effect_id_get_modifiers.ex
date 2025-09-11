defmodule Esi.Api.DogmaEffectsEffectIdGetModifiers do
  @moduledoc """
  Provides struct and type for a DogmaEffectsEffectIdGetModifiers
  """

  @type t :: %__MODULE__{
          domain: String.t() | nil,
          effect_id: integer | nil,
          func: String.t(),
          modified_attribute_id: integer | nil,
          modifying_attribute_id: integer | nil,
          operator: integer | nil
        }

  defstruct [
    :domain,
    :effect_id,
    :func,
    :modified_attribute_id,
    :modifying_attribute_id,
    :operator
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      domain: {:string, :generic},
      effect_id: :integer,
      func: {:string, :generic},
      modified_attribute_id: :integer,
      modifying_attribute_id: :integer,
      operator: :integer
    ]
  end
end
