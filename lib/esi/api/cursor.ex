defmodule Esi.Api.Cursor do
  @moduledoc """
  Provides struct and type for a Cursor
  """

  @type t :: %__MODULE__{after: String.t() | nil, before: String.t() | nil}

  defstruct [:after, :before]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [after: {:string, :generic}, before: {:string, :generic}]
  end
end
