defmodule Esi.Api.StatusGet do
  @moduledoc """
  Provides struct and type for a StatusGet
  """

  @type t :: %__MODULE__{
          players: integer,
          server_version: String.t(),
          start_time: DateTime.t(),
          vip: boolean | nil
        }

  defstruct [:players, :server_version, :start_time, :vip]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      players: :integer,
      server_version: {:string, :generic},
      start_time: {:string, :date_time},
      vip: :boolean
    ]
  end
end
