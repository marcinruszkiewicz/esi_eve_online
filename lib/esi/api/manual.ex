defmodule Esi.Api.Manual do
  @moduledoc """
  Provides struct and type for a Manual
  """

  @type t :: %__MODULE__{manual: map | nil}

  defstruct [:manual]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [manual: :map]
  end
end
