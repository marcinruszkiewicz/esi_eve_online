defmodule Esi.Api.CorporationsProjectsDetailDetails do
  @moduledoc """
  Provides struct and type for a CorporationsProjectsDetailDetails
  """

  @type t :: %__MODULE__{
          career: String.t(),
          created: DateTime.t(),
          description: String.t(),
          expires: DateTime.t() | nil,
          finished: DateTime.t() | nil
        }

  defstruct [:career, :created, :description, :expires, :finished]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      career:
        {:enum, ["Unspecified", "Explorer", "Industrialist", "Enforcer", "Soldier of Fortune"]},
      created: {:string, :date_time},
      description: {:string, :generic},
      expires: {:string, :date_time},
      finished: {:string, :date_time}
    ]
  end
end
