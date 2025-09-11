defmodule Esi.Api.CorporationsProjectsDetailConfigurationmatchersignature do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationmatchersignature
  """

  @type t :: %__MODULE__{signature_type_id: integer | nil}

  defstruct [:signature_type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [signature_type_id: :integer]
  end
end
