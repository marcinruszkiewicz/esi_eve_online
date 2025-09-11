defmodule Esi.Api.CorporationsCorporationIdShareholdersGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdShareholdersGet
  """

  @type t :: %__MODULE__{
          share_count: integer,
          shareholder_id: integer,
          shareholder_type: String.t()
        }

  defstruct [:share_count, :shareholder_id, :shareholder_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      share_count: :integer,
      shareholder_id: :integer,
      shareholder_type: {:enum, ["character", "corporation"]}
    ]
  end
end
