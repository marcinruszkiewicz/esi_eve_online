defmodule Esi.Api.CorporationsProjectsListing do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsListing
  """

  @type t :: %__MODULE__{cursor: Esi.Api.Cursor.t() | nil, projects: [map] | nil}

  defstruct [:cursor, :projects]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cursor: {Esi.Api.Cursor, :t}, projects: {:union, [[:map], :null]}]
  end
end
