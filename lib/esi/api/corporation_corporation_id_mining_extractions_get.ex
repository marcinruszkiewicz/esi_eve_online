defmodule Esi.Api.CorporationCorporationIdMiningExtractionsGet do
  @moduledoc """
  Provides struct and type for a CorporationCorporationIdMiningExtractionsGet
  """

  @type t :: %__MODULE__{
          chunk_arrival_time: DateTime.t(),
          extraction_start_time: DateTime.t(),
          moon_id: integer,
          natural_decay_time: DateTime.t(),
          structure_id: integer
        }

  defstruct [
    :chunk_arrival_time,
    :extraction_start_time,
    :moon_id,
    :natural_decay_time,
    :structure_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      chunk_arrival_time: {:string, :date_time},
      extraction_start_time: {:string, :date_time},
      moon_id: :integer,
      natural_decay_time: {:string, :date_time},
      structure_id: :integer
    ]
  end
end
