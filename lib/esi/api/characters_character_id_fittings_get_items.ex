defmodule Esi.Api.CharactersCharacterIdFittingsGetItems do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdFittingsGetItems
  """

  @type t :: %__MODULE__{flag: String.t(), quantity: integer, type_id: integer}

  defstruct [:flag, :quantity, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      flag:
        {:enum,
         [
           "Cargo",
           "DroneBay",
           "FighterBay",
           "HiSlot0",
           "HiSlot1",
           "HiSlot2",
           "HiSlot3",
           "HiSlot4",
           "HiSlot5",
           "HiSlot6",
           "HiSlot7",
           "Invalid",
           "LoSlot0",
           "LoSlot1",
           "LoSlot2",
           "LoSlot3",
           "LoSlot4",
           "LoSlot5",
           "LoSlot6",
           "LoSlot7",
           "MedSlot0",
           "MedSlot1",
           "MedSlot2",
           "MedSlot3",
           "MedSlot4",
           "MedSlot5",
           "MedSlot6",
           "MedSlot7",
           "RigSlot0",
           "RigSlot1",
           "RigSlot2",
           "ServiceSlot0",
           "ServiceSlot1",
           "ServiceSlot2",
           "ServiceSlot3",
           "ServiceSlot4",
           "ServiceSlot5",
           "ServiceSlot6",
           "ServiceSlot7",
           "SubSystemSlot0",
           "SubSystemSlot1",
           "SubSystemSlot2",
           "SubSystemSlot3"
         ]},
      quantity: :integer,
      type_id: :integer
    ]
  end
end
