defmodule Esi.Api.UniverseCategoriesCategoryIdGet do
  @moduledoc """
  Provides struct and type for a UniverseCategoriesCategoryIdGet
  """

  @type t :: %__MODULE__{
          category_id: integer,
          groups: [integer],
          name: String.t(),
          published: boolean
        }

  defstruct [:category_id, :groups, :name, :published]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [category_id: :integer, groups: [:integer], name: {:string, :generic}, published: :boolean]
  end
end
