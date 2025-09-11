defmodule Esi.Api.UniverseStargatesStargateIdGet do
  @moduledoc """
  Provides struct and type for a UniverseStargatesStargateIdGet
  """

  @type t :: %__MODULE__{
          destination: Esi.Api.UniverseStargatesStargateIdGetDestination.t(),
          name: String.t(),
          position: Esi.Api.UniverseStargatesStargateIdGetPosition.t(),
          stargate_id: integer,
          system_id: integer,
          type_id: integer
        }

  defstruct [:destination, :name, :position, :stargate_id, :system_id, :type_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      destination: {Esi.Api.UniverseStargatesStargateIdGetDestination, :t},
      name: {:string, :generic},
      position: {Esi.Api.UniverseStargatesStargateIdGetPosition, :t},
      stargate_id: :integer,
      system_id: :integer,
      type_id: :integer
    ]
  end
end
