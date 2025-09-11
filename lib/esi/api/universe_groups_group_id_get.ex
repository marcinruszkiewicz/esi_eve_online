defmodule Esi.Api.UniverseGroupsGroupIdGet do
  @moduledoc """
  Provides struct and type for a UniverseGroupsGroupIdGet
  """

  @type t :: %__MODULE__{
          category_id: integer,
          group_id: integer,
          name: String.t(),
          published: boolean,
          types: [integer]
        }

  defstruct [:category_id, :group_id, :name, :published, :types]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      category_id: :integer,
      group_id: :integer,
      name: {:string, :generic},
      published: :boolean,
      types: [:integer]
    ]
  end
end
