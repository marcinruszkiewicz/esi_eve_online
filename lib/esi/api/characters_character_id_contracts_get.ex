defmodule Esi.Api.CharactersCharacterIdContractsGet do
  @moduledoc """
  Provides struct and type for a CharactersCharacterIdContractsGet
  """

  @type t :: %__MODULE__{
          acceptor_id: integer,
          assignee_id: integer,
          availability: String.t(),
          buyout: number | nil,
          collateral: number | nil,
          contract_id: integer,
          date_accepted: DateTime.t() | nil,
          date_completed: DateTime.t() | nil,
          date_expired: DateTime.t(),
          date_issued: DateTime.t(),
          days_to_complete: integer | nil,
          end_location_id: integer | nil,
          for_corporation: boolean,
          issuer_corporation_id: integer,
          issuer_id: integer,
          price: number | nil,
          reward: number | nil,
          start_location_id: integer | nil,
          status: String.t(),
          title: String.t() | nil,
          type: String.t(),
          volume: number | nil
        }

  defstruct [
    :acceptor_id,
    :assignee_id,
    :availability,
    :buyout,
    :collateral,
    :contract_id,
    :date_accepted,
    :date_completed,
    :date_expired,
    :date_issued,
    :days_to_complete,
    :end_location_id,
    :for_corporation,
    :issuer_corporation_id,
    :issuer_id,
    :price,
    :reward,
    :start_location_id,
    :status,
    :title,
    :type,
    :volume
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      acceptor_id: :integer,
      assignee_id: :integer,
      availability: {:enum, ["public", "personal", "corporation", "alliance"]},
      buyout: :number,
      collateral: :number,
      contract_id: :integer,
      date_accepted: {:string, :date_time},
      date_completed: {:string, :date_time},
      date_expired: {:string, :date_time},
      date_issued: {:string, :date_time},
      days_to_complete: :integer,
      end_location_id: :integer,
      for_corporation: :boolean,
      issuer_corporation_id: :integer,
      issuer_id: :integer,
      price: :number,
      reward: :number,
      start_location_id: :integer,
      status:
        {:enum,
         [
           "outstanding",
           "in_progress",
           "finished_issuer",
           "finished_contractor",
           "finished",
           "cancelled",
           "rejected",
           "failed",
           "deleted",
           "reversed"
         ]},
      title: {:string, :generic},
      type: {:enum, ["unknown", "item_exchange", "auction", "courier", "loan"]},
      volume: :number
    ]
  end
end
