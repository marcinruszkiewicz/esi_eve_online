defmodule Esi.Api.CorporationsCorporationIdRolesHistoryGet do
  @moduledoc """
  Provides struct and type for a CorporationsCorporationIdRolesHistoryGet
  """

  @type t :: %__MODULE__{
          changed_at: DateTime.t(),
          character_id: integer,
          issuer_id: integer,
          new_roles: [String.t()],
          old_roles: [String.t()],
          role_type: String.t()
        }

  defstruct [:changed_at, :character_id, :issuer_id, :new_roles, :old_roles, :role_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      changed_at: {:string, :date_time},
      character_id: :integer,
      issuer_id: :integer,
      new_roles: [
        enum: [
          "Account_Take_1",
          "Account_Take_2",
          "Account_Take_3",
          "Account_Take_4",
          "Account_Take_5",
          "Account_Take_6",
          "Account_Take_7",
          "Accountant",
          "Auditor",
          "Brand_Manager",
          "Communications_Officer",
          "Config_Equipment",
          "Config_Starbase_Equipment",
          "Container_Take_1",
          "Container_Take_2",
          "Container_Take_3",
          "Container_Take_4",
          "Container_Take_5",
          "Container_Take_6",
          "Container_Take_7",
          "Contract_Manager",
          "Deliveries_Container_Take",
          "Deliveries_Query",
          "Deliveries_Take",
          "Diplomat",
          "Director",
          "Factory_Manager",
          "Fitting_Manager",
          "Hangar_Query_1",
          "Hangar_Query_2",
          "Hangar_Query_3",
          "Hangar_Query_4",
          "Hangar_Query_5",
          "Hangar_Query_6",
          "Hangar_Query_7",
          "Hangar_Take_1",
          "Hangar_Take_2",
          "Hangar_Take_3",
          "Hangar_Take_4",
          "Hangar_Take_5",
          "Hangar_Take_6",
          "Hangar_Take_7",
          "Junior_Accountant",
          "Personnel_Manager",
          "Project_Manager",
          "Rent_Factory_Facility",
          "Rent_Office",
          "Rent_Research_Facility",
          "Security_Officer",
          "Skill_Plan_Manager",
          "Starbase_Defense_Operator",
          "Starbase_Fuel_Technician",
          "Station_Manager",
          "Trader"
        ]
      ],
      old_roles: [
        enum: [
          "Account_Take_1",
          "Account_Take_2",
          "Account_Take_3",
          "Account_Take_4",
          "Account_Take_5",
          "Account_Take_6",
          "Account_Take_7",
          "Accountant",
          "Auditor",
          "Brand_Manager",
          "Communications_Officer",
          "Config_Equipment",
          "Config_Starbase_Equipment",
          "Container_Take_1",
          "Container_Take_2",
          "Container_Take_3",
          "Container_Take_4",
          "Container_Take_5",
          "Container_Take_6",
          "Container_Take_7",
          "Contract_Manager",
          "Deliveries_Container_Take",
          "Deliveries_Query",
          "Deliveries_Take",
          "Diplomat",
          "Director",
          "Factory_Manager",
          "Fitting_Manager",
          "Hangar_Query_1",
          "Hangar_Query_2",
          "Hangar_Query_3",
          "Hangar_Query_4",
          "Hangar_Query_5",
          "Hangar_Query_6",
          "Hangar_Query_7",
          "Hangar_Take_1",
          "Hangar_Take_2",
          "Hangar_Take_3",
          "Hangar_Take_4",
          "Hangar_Take_5",
          "Hangar_Take_6",
          "Hangar_Take_7",
          "Junior_Accountant",
          "Personnel_Manager",
          "Project_Manager",
          "Rent_Factory_Facility",
          "Rent_Office",
          "Rent_Research_Facility",
          "Security_Officer",
          "Skill_Plan_Manager",
          "Starbase_Defense_Operator",
          "Starbase_Fuel_Technician",
          "Station_Manager",
          "Trader"
        ]
      ],
      role_type:
        {:enum,
         [
           "grantable_roles",
           "grantable_roles_at_base",
           "grantable_roles_at_hq",
           "grantable_roles_at_other",
           "roles",
           "roles_at_base",
           "roles_at_hq",
           "roles_at_other"
         ]}
    ]
  end
end
