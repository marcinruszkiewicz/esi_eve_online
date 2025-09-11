defmodule Esi.Api.CorporationsCorporationIdMedalsIssuedGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdMedalsIssuedGet
  """

  @type t :: %__MODULE__{
          character_id: integer,
          issued_at: DateTime.t(),
          issuer_id: integer,
          medal_id: integer,
          reason: String.t(),
          status: String.t()
        }

  defstruct [:character_id, :issued_at, :issuer_id, :medal_id, :reason, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      character_id: :integer,
      issued_at: {:string, :date_time},
      issuer_id: :integer,
      medal_id: :integer,
      reason: {:string, :generic},
      status: {:enum, ["private", "public"]}
    ]
  end
end
