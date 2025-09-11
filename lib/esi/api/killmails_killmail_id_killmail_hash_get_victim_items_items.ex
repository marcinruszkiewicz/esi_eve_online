defmodule Esi.Api.KillmailsKillmailIdKillmailHashGetVictimItemsItems do
  @moduledoc """
  Provides struct and type for a KillmailsKillmailIdKillmailHashGetVictimItemsItems
  """

  @type t :: %__MODULE__{
          flag: integer,
          item_type_id: integer,
          quantity_destroyed: integer | nil,
          quantity_dropped: integer | nil,
          singleton: integer
        }

  defstruct [:flag, :item_type_id, :quantity_destroyed, :quantity_dropped, :singleton]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      flag: :integer,
      item_type_id: :integer,
      quantity_destroyed: :integer,
      quantity_dropped: :integer,
      singleton: :integer
    ]
  end
end
