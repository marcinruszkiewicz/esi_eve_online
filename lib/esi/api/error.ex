defmodule Esi.Api.Error do
  @moduledoc """
  Provides struct and type for a Error
  """

  @type t :: %__MODULE__{details: [map] | nil, error: String.t()}

  defstruct [:details, :error]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [details: {:union, [[:map], :null]}, error: {:string, :generic}]
  end
end
