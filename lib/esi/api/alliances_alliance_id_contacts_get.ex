defmodule Esi.Api.AlliancesAllianceIdContactsGet do
  @moduledoc """
  Provides struct and type for a AlliancesAllianceIdContactsGet
  """

  @type t :: %__MODULE__{
          contact_id: integer,
          contact_type: String.t(),
          label_ids: [integer] | nil,
          standing: number
        }

  defstruct [:contact_id, :contact_type, :label_ids, :standing]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contact_id: :integer,
      contact_type: {:enum, ["character", "corporation", "alliance", "faction"]},
      label_ids: [:integer],
      standing: :number
    ]
  end
end
