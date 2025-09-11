defmodule Esi.Api.UniverseAncestriesGet do
  @moduledoc """
  Provides struct and type for a UniverseAncestriesGet
  """

  @type t :: %__MODULE__{
          bloodline_id: integer,
          description: String.t(),
          icon_id: integer | nil,
          id: integer,
          name: String.t(),
          short_description: String.t() | nil
        }

  defstruct [:bloodline_id, :description, :icon_id, :id, :name, :short_description]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bloodline_id: :integer,
      description: {:string, :generic},
      icon_id: :integer,
      id: :integer,
      name: {:string, :generic},
      short_description: {:string, :generic}
    ]
  end
end
