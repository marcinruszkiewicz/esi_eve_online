defmodule Esi.Api.CorporationsCorporationIdStarbasesGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdStarbasesGet
  """

  @type t :: %__MODULE__{
          moon_id: integer | nil,
          onlined_since: DateTime.t() | nil,
          reinforced_until: DateTime.t() | nil,
          starbase_id: integer,
          state: String.t() | nil,
          system_id: integer,
          type_id: integer,
          unanchor_at: DateTime.t() | nil
        }

  defstruct [
    :moon_id,
    :onlined_since,
    :reinforced_until,
    :starbase_id,
    :state,
    :system_id,
    :type_id,
    :unanchor_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      moon_id: :integer,
      onlined_since: {:string, :date_time},
      reinforced_until: {:string, :date_time},
      starbase_id: :integer,
      state: {:enum, ["offline", "online", "onlining", "reinforced", "unanchoring"]},
      system_id: :integer,
      type_id: :integer,
      unanchor_at: {:string, :date_time}
    ]
  end
end
