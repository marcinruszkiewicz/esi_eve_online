defmodule ESI.API do
  @moduledoc """
  Legacy compatibility module for ESI.API.

  This module provides access to all ESI API endpoints using the legacy
  interface pattern. Each submodule (Alliance, Character, etc.) contains
  functions that return `ESI.Request.t` structs compatible with the
  legacy `|> ESI.request()` pattern.

  ## Usage

      # Legacy pattern - still works exactly the same
      ESI.API.Alliance.alliances() |> ESI.request()
      ESI.API.Character.character(12345) |> ESI.request!(token: "token")
      ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(100)

  ## API Modules

  The following API modules are available, matching the legacy library:

  - `ESI.API.Alliance` - Alliance information and member corporations
  - `ESI.API.Character` - Character information, assets, mail, etc.
  - `ESI.API.Contract` - Contract information
  - `ESI.API.Corporation` - Corporation information
  - `ESI.API.Dogma` - Dogma attributes and effects
  - `ESI.API.FactionWarfare` - Faction warfare statistics
  - `ESI.API.Fleet` - Fleet management
  - `ESI.API.Incursion` - Incursion information
  - `ESI.API.Industry` - Industry jobs and facilities
  - `ESI.API.Insurance` - Ship insurance information
  - `ESI.API.Killmail` - Killmail data
  - `ESI.API.Loyalty` - Loyalty point stores
  - `ESI.API.Market` - Market orders and history
  - `ESI.API.Route` - Route planning
  - `ESI.API.Sovereignty` - Sovereignty information
  - `ESI.API.Status` - Server status
  - `ESI.API.UI` - In-game UI interactions
  - `ESI.API.Universe` - Universe reference data
  - `ESI.API.War` - War information

  """

  @doc """
  Returns the version of the ESI specification this compatibility layer supports.
  """
  @spec version() :: String.t()
  def version do
    # Based on the OpenAPI spec version
    "2024.09"
  end
end
