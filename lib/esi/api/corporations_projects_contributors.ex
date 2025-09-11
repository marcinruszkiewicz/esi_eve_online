defmodule Esi.Api.CorporationsProjectsContributors do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsContributors
  """

  @type t :: %__MODULE__{contributors: [map] | nil, cursor: Esi.Api.Cursor.t() | nil}

  defstruct [:contributors, :cursor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contributors: {:union, [[:map], :null]}, cursor: {Esi.Api.Cursor, :t}]
  end
end
