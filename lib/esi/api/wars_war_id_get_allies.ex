defmodule Esi.Api.WarsWarIdGetAllies do
  @moduledoc """
  Provides struct and type for a WarsWarIdGetAllies
  """

  @type t :: %__MODULE__{alliance_id: integer | nil, corporation_id: integer | nil}

  defstruct [:alliance_id, :corporation_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [alliance_id: :integer, corporation_id: :integer]
  end
end
