defmodule Esi.Api.WarsWarIdGet do
  @moduledoc """
  Provides struct and type for a WarsWarIdGet
  """

  @type t :: %__MODULE__{
          aggressor: Esi.Api.WarsWarIdGetAggressor.t(),
          allies: [Esi.Api.WarsWarIdGetAllies.t()] | nil,
          declared: DateTime.t(),
          defender: Esi.Api.WarsWarIdGetDefender.t(),
          finished: DateTime.t() | nil,
          id: integer,
          mutual: boolean,
          open_for_allies: boolean,
          retracted: DateTime.t() | nil,
          started: DateTime.t() | nil
        }

  defstruct [
    :aggressor,
    :allies,
    :declared,
    :defender,
    :finished,
    :id,
    :mutual,
    :open_for_allies,
    :retracted,
    :started
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      aggressor: {Esi.Api.WarsWarIdGetAggressor, :t},
      allies: [{Esi.Api.WarsWarIdGetAllies, :t}],
      declared: {:string, :date_time},
      defender: {Esi.Api.WarsWarIdGetDefender, :t},
      finished: {:string, :date_time},
      id: :integer,
      mutual: :boolean,
      open_for_allies: :boolean,
      retracted: {:string, :date_time},
      started: {:string, :date_time}
    ]
  end
end
