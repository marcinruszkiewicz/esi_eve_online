defmodule Esi.Api.CorporationsProjectsDetailConfigurationmanufactureitem do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationmanufactureitem
  """

  @type t :: %__MODULE__{
          docking_locations: [Esi.Api.StationId.t() | Esi.Api.StructureId.t()] | nil,
          items: [Esi.Api.GroupId.t() | Esi.Api.TypeId.t()] | nil,
          owner: String.t()
        }

  defstruct [:docking_locations, :items, :owner]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      docking_locations: [union: [{Esi.Api.StationId, :t}, {Esi.Api.StructureId, :t}]],
      items: [union: [{Esi.Api.GroupId, :t}, {Esi.Api.TypeId, :t}]],
      owner: {:enum, ["Any", "Corporation", "Character"]}
    ]
  end
end
