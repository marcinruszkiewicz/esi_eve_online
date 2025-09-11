defmodule Esi.Api.GroupId do
  @moduledoc """
  Provides struct and types for a GroupId
  """

  @type t :: %__MODULE__{group_id: integer | nil}

  defstruct [:group_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [group_id: :integer]
  end
end
