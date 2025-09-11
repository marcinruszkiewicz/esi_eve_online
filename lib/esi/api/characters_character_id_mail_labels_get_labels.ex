defmodule Esi.Api.CharactersCharacterIdMailLabelsGetLabels do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMailLabelsGetLabels
  """

  @type t :: %__MODULE__{
          color: String.t() | nil,
          label_id: integer | nil,
          name: String.t() | nil,
          unread_count: integer | nil
        }

  defstruct [:color, :label_id, :name, :unread_count]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      color:
        {:enum,
         [
           "#0000fe",
           "#006634",
           "#0099ff",
           "#00ff33",
           "#01ffff",
           "#349800",
           "#660066",
           "#666666",
           "#999999",
           "#99ffff",
           "#9a0000",
           "#ccff9a",
           "#e6e6e6",
           "#fe0000",
           "#ff6600",
           "#ffff01",
           "#ffffcd",
           "#ffffff"
         ]},
      label_id: :integer,
      name: {:string, :generic},
      unread_count: :integer
    ]
  end
end
