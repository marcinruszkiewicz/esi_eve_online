defmodule Esi.Api.CorporationsProjectsDetailConfigurationdeliveritem do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailConfigurationdeliveritem
  """

  @type t :: %__MODULE__{
          docking_locations: [Esi.Api.StationId.t() | Esi.Api.StructureId.t()] | nil,
          items: [Esi.Api.GroupId.t() | Esi.Api.TypeId.t()] | nil,
          office_id: integer | nil
        }

  defstruct [:docking_locations, :items, :office_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      docking_locations: [union: [{Esi.Api.StationId, :t}, {Esi.Api.StructureId, :t}]],
      items: [union: [{Esi.Api.GroupId, :t}, {Esi.Api.TypeId, :t}]],
      office_id: :integer
    ]
  end
end
