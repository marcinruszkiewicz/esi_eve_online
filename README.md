# ESI Eve Online

A modern Elixir client for EVE Online's ESI (EVE Swagger Interface) API. This library provides a clean, type-safe interface to all EVE Online ESI endpoints with automatic code generation, comprehensive error handling, and full backward compatibility with the legacy `esi` library.

## Installation

Add `esi_eve_online` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:esi_eve_online, "~> 1.0"}
  ]
end
```

Then run `mix deps.get` to install the dependency.

Don't forget to configure your User Agent in the `config/config.exs`:

```elixir
config :esi_eve_online,
  user_agent: "MyCoolApp/1.0 (email@example.com)"
```

## Quick Start

### Basic API Usage

```elixir
# Get alliance information (no authentication required)
{:ok, alliance} = Esi.Api.Alliances.alliance(99005443)
IO.puts("Alliance: #{alliance["name"]} [#{alliance["ticker"]}]")

# Get all alliances (returns list of IDs)
{:ok, alliance_ids} = Esi.Api.Alliances.alliances()
IO.puts("Found #{length(alliance_ids)} alliances")

# Get character information (no authentication required)
{:ok, character} = Esi.Api.Characters.character(1234567890)
IO.puts("Character: #{character["name"]}")
```

### Authenticated Requests

Most ESI endpoints require authentication via OAuth2 access tokens. You can get the token for example using the [Überauth EVE Online](https://hex.pm/packages/ueberauth_eve_online) package.

```elixir
# Get character assets (requires authentication)
opts = [token: "your_access_token"]
{:ok, assets} = Esi.Api.Characters.assets(character_id, opts)

# Get character mail
{:ok, mail} = Esi.Api.Characters.mail(character_id, opts)

# Create a new fitting
fitting_data = %{
  "name" => "My Awesome Fit",
  "ship_type_id" => 587,
  "items" => [...]
}
{:ok, fitting_id} = Esi.Api.Characters.create_fittings(character_id, fitting_data, opts)
```

### Working with Paginated Data

Many ESI endpoints return paginated results. Use the legacy `stream!` function for automatic pagination:

```elixir
# Get all universe groups (paginated endpoint)
# This automatically handles pagination and returns a stream
all_groups = ESI.API.Universe.groups() |> ESI.stream!() |> Enum.to_list()
IO.puts("Found #{length(all_groups)} universe groups")

# Take only the first 100 groups
first_100_groups = ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(100)

# Get all market groups with pagination
market_groups = ESI.API.Market.groups() |> ESI.stream!() |> Enum.to_list()

# Works with any paginated endpoint
all_systems = ESI.API.Universe.systems() |> ESI.stream!() |> Enum.to_list()
```

### Modern Streaming API

The new client provides convenient streaming functions for paginated endpoints:

```elixir
# Stream all character assets with automatic pagination
assets = EsiEveOnline.stream("/characters/12345/assets", token: "access_token")
|> Enum.to_list()

# Stream universe groups (no authentication required)
groups = EsiEveOnline.stream("/universe/groups")
|> Stream.take(50)
|> Enum.to_list()

# Process assets as they come in (lazy evaluation)
unique_types = EsiEveOnline.stream("/characters/12345/assets", token: "access_token")
|> Stream.flat_map(& &1)  # Flatten all pages
|> Stream.map(& &1.type_id)  # Extract type IDs
|> Enum.uniq()

# Using convenience functions from the Streaming module
character_assets = EsiEveOnline.Streaming.character_assets(12345, token: "access_token")
|> Enum.to_list()

corporation_assets = EsiEveOnline.Streaming.corporation_assets(67890, token: "access_token")
|> Enum.to_list()

# Stream universe groups (no authentication required)
universe_groups = EsiEveOnline.Streaming.universe_groups()
|> Stream.take(100)
|> Enum.to_list()
```

### POST Requests with Data

```elixir
# Resolve character/corporation/alliance names from IDs
ids = [1234567890, 99005443, 98356193]
{:ok, names} = Esi.Api.Universe.names(ids)

# Resolve IDs from names
names = ["CCP Falcon", "Goonswarm Federation"]
{:ok, ids} = Esi.Api.Universe.ids(names)

# Fleet operations (requires fleet commander role)
invitation = %{
  "character_id" => 1234567890,
  "role" => "squad_member"
}
{:ok, _} = Esi.Api.Fleets.invite(fleet_id, invitation, opts)
```

### Unified HTTP Interface

For direct HTTP calls without generated modules:

```elixir
# Direct HTTP calls (alternative to generated modules)
{:ok, status} = EsiEveOnline.get("/status")
{:ok, alliance} = EsiEveOnline.get("/alliances/99005443")

# With authentication
{:ok, character} = EsiEveOnline.get("/characters/1234567890", token: "access_token")

# POST with body
{:ok, names} = EsiEveOnline.post("/universe/names", [1234567890, 99005443])

# Bang versions (raise on error)
alliance = EsiEveOnline.get!("/alliances/99005443")
```

### Error Handling

All functions return standardized `{:ok, result}` or `{:error, %Esi.Error{}}` tuples:

```elixir
case Esi.Api.Characters.character(invalid_id) do
  {:ok, character} ->
    IO.puts("Character: #{character["name"]}")
  
  {:error, %Esi.Error{type: :api_error, status: 404}} ->
    IO.puts("Character not found")
  
  {:error, %Esi.Error{type: :api_error, status: 420, retry_after: seconds}} ->
    IO.puts("Rate limited, retry after #{seconds} seconds")
  
  {:error, %Esi.Error{type: :timeout_error}} ->
    IO.puts("Request timed out")
  
  {:error, error} ->
    IO.puts("Request failed: #{error.message}")
end
```

### Configuration Options

```elixir
# Custom timeout and retries
opts = [
  token: "access_token",
  timeout: 60_000,      # 60 seconds
  retries: 5,           # retry up to 5 times
  user_agent: "MyApp/1.0"
]

{:ok, result} = Esi.Api.Characters.assets(character_id, opts)

# Custom base URL (for testing)
opts = [base_url: "https://esi.evetech.net/dev"]
{:ok, result} = EsiEveOnline.get("/status", opts)
```

## Migration from Legacy ESI Library

This library provides full backward compatibility with the legacy `esi` library. You can migrate gradually:

### Legacy Patterns (Still Supported)

```elixir
# All legacy patterns work exactly as before
ESI.API.Alliance.alliances() |> ESI.request()
ESI.API.Character.character(12345) |> ESI.request!(token: "access_token")

# Automatic pagination with stream!
ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(100)
ESI.API.Market.groups() |> ESI.stream!() |> Enum.to_list()

# With pagination headers
{:ok, data, max_pages} = ESI.API.Universe.groups() |> ESI.request_with_headers()
```

### Modern Patterns (Recommended)

```elixir
# Legacy approach
ESI.API.Character.character(char_id) |> ESI.request!(token: token)

# Modern approach (equivalent)
{:ok, character} = Esi.Api.Characters.character(char_id, token: token)

# Or using the unified interface
{:ok, character} = EsiEveOnline.get("/characters/#{char_id}", token: token)
```

## Development

### Regenerating API Modules

The API modules are automatically generated from the OpenAPI specification. To regenerate them:

```bash
# Remove existing API modules (recommended for clean regeneration)
rm -rf lib/esi/api

# Regenerate from OpenAPI spec
mix api.gen default priv/openapi.yaml
```

**Note**: Always remove the `lib/esi/api` directory before regenerating to ensure old files don't persist and cause conflicts.

### Testing

Run the comprehensive test suite:

```bash
# Run all tests
mix test

# Run with integration tests
mix test --include integration

# Run specific test files
mix test test/esi/client_test.exs
mix test test/esi/custom_processor_test.exs
```

## Contributing

This library is actively developed as a community replacement for the legacy ESI library. Contributions, bug reports, and feature requests are welcome via GitHub issues and pull requests.

When contributing:
1. Update the OpenAPI specification in `priv/openapi.yaml` if needed
2. Modify the custom processor in `lib/esi/custom_processor.ex` for naming improvements
3. Regenerate API modules using the process above
4. Test your changes thoroughly

## License

MIT License - See LICENSE file for details.

**Note**: This package is not officially supported or endorsed by CCP Games or EVE Online. It is a community-maintained utility for EVE Online developers.

