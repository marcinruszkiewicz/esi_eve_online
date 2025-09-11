defmodule Esi.Api.CharactersCharacterIdMiningGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdMiningGet
  """

  @type t :: %__MODULE__{
          date: Date.t(),
          quantity: integer,
          solar_system_id: integer,
          type_id: integer
        }

  defstruct [:date, :quantity, :solar_system_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [date: {:string, :date}, quantity: :integer, solar_system_id: :integer, type_id: :integer]
  end
end
