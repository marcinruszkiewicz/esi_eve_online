defmodule Esi.Api.MarketsGroupsMarketGroupIdGet do
  @moduledoc """
  Provides struct and type for a MarketsGroupsMarketGroupIdGet
  """

  @type t :: %__MODULE__{
          description: String.t(),
          market_group_id: integer,
          name: String.t(),
          parent_group_id: integer | nil,
          types: [integer]
        }

  defstruct [:description, :market_group_id, :name, :parent_group_id, :types]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      market_group_id: :integer,
      name: {:string, :generic},
      parent_group_id: :integer,
      types: [:integer]
    ]
  end
end
