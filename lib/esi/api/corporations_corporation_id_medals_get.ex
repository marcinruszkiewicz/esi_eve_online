defmodule Esi.Api.CorporationsCorporationIdMedalsGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdMedalsGet
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t(),
          creator_id: integer,
          description: String.t(),
          medal_id: integer,
          title: String.t()
        }

  defstruct [:created_at, :creator_id, :description, :medal_id, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:string, :date_time},
      creator_id: :integer,
      description: {:string, :generic},
      medal_id: :integer,
      title: {:string, :generic}
    ]
  end
end
