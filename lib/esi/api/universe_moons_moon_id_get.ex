defmodule Esi.Api.UniverseMoonsMoonIdGet do
  @moduledoc """
  Provides struct and type for a UniverseMoonsMoonIdGet
  """

  @type t :: %__MODULE__{
          moon_id: integer,
          name: String.t(),
          position: Esi.Api.UniverseMoonsMoonIdGetPosition.t(),
          system_id: integer
        }

  defstruct [:moon_id, :name, :position, :system_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      moon_id: :integer,
      name: {:string, :generic},
      position: {Esi.Api.UniverseMoonsMoonIdGetPosition, :t},
      system_id: :integer
    ]
  end
end
