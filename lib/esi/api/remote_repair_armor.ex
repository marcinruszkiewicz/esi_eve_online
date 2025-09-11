defmodule Esi.Api.RemoteRepairArmor do
  @moduledoc """
  Provides struct and type for a RemoteRepairArmor
  """

  @type t :: %__MODULE__{
          remote_repair_armor:
            Esi.Api.CorporationsProjectsDetailConfigurationremoterepairarmor.t() | nil
        }

  defstruct [:remote_repair_armor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [remote_repair_armor: {Esi.Api.CorporationsProjectsDetailConfigurationremoterepairarmor, :t}]
  end
end
