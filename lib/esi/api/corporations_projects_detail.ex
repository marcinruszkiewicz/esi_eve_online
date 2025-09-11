defmodule Esi.Api.CorporationsProjectsDetail do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetail
  """

  @type t :: %__MODULE__{
          configuration:
            Esi.Api.CaptureFwComplex.t()
            | Esi.Api.DamageShip.t()
            | Esi.Api.DefendFwComplex.t()
            | Esi.Api.DeliverItem.t()
            | Esi.Api.DestroyNpc.t()
            | Esi.Api.DestroyShip.t()
            | Esi.Api.EarnLoyaltyPoint.t()
            | Esi.Api.LostShip.t()
            | Esi.Api.Manual.t()
            | Esi.Api.ManufactureItem.t()
            | Esi.Api.MineMaterial.t()
            | Esi.Api.RemoteBoostShield.t()
            | Esi.Api.RemoteRepairArmor.t()
            | Esi.Api.SalvageWreck.t()
            | Esi.Api.ScanSignature.t()
            | Esi.Api.ShipInsurance.t()
            | Esi.Api.Unknown.t(),
          contribution: Esi.Api.CorporationsProjectsDetailContribution.t() | nil,
          creator: Esi.Api.CorporationsProjectsDetailCreator.t(),
          details: Esi.Api.CorporationsProjectsDetailDetails.t(),
          id: String.t(),
          last_modified: DateTime.t(),
          name: String.t(),
          progress: Esi.Api.CorporationsProjectsDetailProgress.t(),
          reward: Esi.Api.CorporationsProjectsDetailReward.t() | nil,
          state: String.t()
        }

  defstruct [
    :configuration,
    :contribution,
    :creator,
    :details,
    :id,
    :last_modified,
    :name,
    :progress,
    :reward,
    :state
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      configuration:
        {:union,
         [
           {Esi.Api.CaptureFwComplex, :t},
           {Esi.Api.DamageShip, :t},
           {Esi.Api.DefendFwComplex, :t},
           {Esi.Api.DeliverItem, :t},
           {Esi.Api.DestroyNpc, :t},
           {Esi.Api.DestroyShip, :t},
           {Esi.Api.EarnLoyaltyPoint, :t},
           {Esi.Api.LostShip, :t},
           {Esi.Api.Manual, :t},
           {Esi.Api.ManufactureItem, :t},
           {Esi.Api.MineMaterial, :t},
           {Esi.Api.RemoteBoostShield, :t},
           {Esi.Api.RemoteRepairArmor, :t},
           {Esi.Api.SalvageWreck, :t},
           {Esi.Api.ScanSignature, :t},
           {Esi.Api.ShipInsurance, :t},
           {Esi.Api.Unknown, :t}
         ]},
      contribution: {Esi.Api.CorporationsProjectsDetailContribution, :t},
      creator: {Esi.Api.CorporationsProjectsDetailCreator, :t},
      details: {Esi.Api.CorporationsProjectsDetailDetails, :t},
      id: {:string, :uuid},
      last_modified: {:string, :date_time},
      name: {:string, :generic},
      progress: {Esi.Api.CorporationsProjectsDetailProgress, :t},
      reward: {Esi.Api.CorporationsProjectsDetailReward, :t},
      state: {:enum, ["Unspecified", "Active", "Closed", "Completed", "Expired", "Deleted"]}
    ]
  end
end
