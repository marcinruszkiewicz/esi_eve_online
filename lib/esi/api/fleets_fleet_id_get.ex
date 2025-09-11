defmodule Esi.Api.FleetsFleetIdGet do
  @moduledoc """
  Provides struct and type for a FleetsFleetIdGet
  """

  @type t :: %__MODULE__{
          is_free_move: boolean,
          is_registered: boolean,
          is_voice_enabled: boolean,
          motd: String.t()
        }

  defstruct [:is_free_move, :is_registered, :is_voice_enabled, :motd]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      is_free_move: :boolean,
      is_registered: :boolean,
      is_voice_enabled: :boolean,
      motd: {:string, :generic}
    ]
  end
end
