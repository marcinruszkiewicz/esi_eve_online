defmodule Esi.Api.UniverseGraphicsGraphicIdGet do
  @moduledoc """
  Provides struct and type for a UniverseGraphicsGraphicIdGet
  """

  @type t :: %__MODULE__{
          collision_file: String.t() | nil,
          graphic_file: String.t() | nil,
          graphic_id: integer,
          icon_folder: String.t() | nil,
          sof_dna: String.t() | nil,
          sof_fation_name: String.t() | nil,
          sof_hull_name: String.t() | nil,
          sof_race_name: String.t() | nil
        }

  defstruct [
    :collision_file,
    :graphic_file,
    :graphic_id,
    :icon_folder,
    :sof_dna,
    :sof_fation_name,
    :sof_hull_name,
    :sof_race_name
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      collision_file: {:string, :generic},
      graphic_file: {:string, :generic},
      graphic_id: :integer,
      icon_folder: {:string, :generic},
      sof_dna: {:string, :generic},
      sof_fation_name: {:string, :generic},
      sof_hull_name: {:string, :generic},
      sof_race_name: {:string, :generic}
    ]
  end
end
