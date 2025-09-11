defmodule Esi.Api.KillmailsKillmailIdKillmailHashGetVictimItems do
  @moduledoc """
  Provides struct and type for a KillmailsKillmailIdKillmailHashGetVictimItems
  """

  @type t :: %__MODULE__{
          flag: integer,
          item_type_id: integer,
          items: [Esi.Api.KillmailsKillmailIdKillmailHashGetVictimItemsItems.t()] | nil,
          quantity_destroyed: integer | nil,
          quantity_dropped: integer | nil,
          singleton: integer
        }

  defstruct [:flag, :item_type_id, :items, :quantity_destroyed, :quantity_dropped, :singleton]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      flag: :integer,
      item_type_id: :integer,
      items: [{Esi.Api.KillmailsKillmailIdKillmailHashGetVictimItemsItems, :t}],
      quantity_destroyed: :integer,
      quantity_dropped: :integer,
      singleton: :integer
    ]
  end
end
