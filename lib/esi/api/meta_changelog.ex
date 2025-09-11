defmodule Esi.Api.MetaChangelog do
  @moduledoc """
  Provides struct and type for a MetaChangelog
  """

  @type t :: %__MODULE__{changelog: Esi.Api.MetaChangelogChangelog.t()}

  defstruct [:changelog]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [changelog: {Esi.Api.MetaChangelogChangelog, :t}]
  end
end
