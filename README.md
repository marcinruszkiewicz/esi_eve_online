# ESI Eve Online

A modern Elixir client for EVE Online's ESI (EVE Swagger Interface) API, designed to replace the unmaintained [esi](https://hex.pm/packages/esi) library with improved architecture, better maintainability, and modern Elixir practices.

## Installation

```elixir
def deps do
  [
    {:esi_eve_online, "~> 0.2.0"}
  ]
end
```

## Configuration

### User-Agent

The EVE Online ESI API requires a custom User-Agent for all requests. This library enforces this best practice and requires you to configure one for your application. If a User-Agent is not provided, requests will fail with a validation error.

You should configure a global User-Agent in your `config/config.exs` file.

According to [ESI's best practices](https://developers.eveonline.com/docs/services/esi/best-practices/), your User-Agent should be unique and provide contact information. A good format is `ApplicationName/Version (ContactInformation)`. Your email is an example of a good contact information.

**Example Configuration:**

```elixir
# in config/config.exs
config :esi_eve_online,
  user_agent: "MyAwesomeApp/1.0 (contact@example.com)"
```

You can also provide a `user_agent` on a per-request basis, which will override the global configuration:

```elixir
Esi.Api.Universe.systems(user_agent: "MyTemporaryAgent/0.1")
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

### Legacy Compatibility

For users migrating from the old `esi` library, this package provides full backward compatibility through the `ESI` and `ESI.API.*` modules:

```elixir
# All legacy patterns work exactly as before
ESI.API.Alliance.alliances() |> ESI.request()
ESI.API.Character.character(12345) |> ESI.request!(token: "access_token")
ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(100)

# With pagination headers
{:ok, data, max_pages} = ESI.API.Universe.groups() |> ESI.request_with_headers()

# Available legacy modules include:
# ESI.API.Alliance, ESI.API.Character, ESI.API.Corporation, 
# ESI.API.Universe, ESI.API.Market, ESI.API.Fleet, etc.
```

You can gradually migrate from legacy patterns to the new API:

```elixir
# Legacy approach
ESI.API.Character.character(char_id) |> ESI.request!(token: token)

# Modern approach (equivalent)
{:ok, character} = Esi.Api.Characters.character(char_id, token: token)

# Or using the unified interface
{:ok, character} = EsiEveOnline.get("/characters/#{char_id}", token: token)
```

## Documentation

Documentation will be available at [HexDocs](https://hexdocs.pm/esi_eve_online) upon release.

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

### Custom Processor

The library uses a custom OpenAPI processor (`Esi.CustomProcessor`) to generate intuitive, semantic function names:

#### GET Requests - Semantic Resource Names
- **Single resource**: `/alliances/{alliance_id}` → `alliance(alliance_id, opts)`
- **Resource collection**: `/alliances` → `alliances(opts)` 
- **Subresources**: `/characters/{id}/mail` → `mail(character_id, opts)`

#### Other HTTP Methods
- **POST** requests: `create` or action-based names (e.g., `create`, `autopilot_waypoint`)
- **PUT** requests: `update_*` prefix (e.g., `update_mail`, `update_contacts`)
- **DELETE** requests: `delete_*` prefix (e.g., `delete_mail`, `delete_contacts`)
- **Special cases**: UI functions like `openwindow` → `open_*_window`

#### Conflict Resolution & Exceptions
The processor handles naming conflicts with specific exceptions:

- **Fleet members**: POST `/fleets/{id}/members` → `invite()` (not `members()`)
- **Dogma attributes**: GET `/dogma/attributes/{id}` → `attribute()` (singular)

#### Examples of Improved Naming
```elixir
# Old problematic names → New semantic names
put_get_mail        → update_mail
delete_get_contacts → delete_contacts  
get (ambiguous)     → alliance / alliances (specific)
post_openwindow_*   → open_*_window

# Conflict resolution examples
POST /fleets/{id}/members → invite(fleet_id, body, opts)
GET  /fleets/{id}/members → members(fleet_id, opts)
GET  /dogma/attributes    → attributes(opts)  
GET  /dogma/attributes/{id} → attribute(attribute_id, opts)
```

### Configuration

The OpenAPI generator is configured in `config/config.exs`:

```elixir
config :oapi_generator, default: [
  processor: Esi.CustomProcessor,
  naming: [operation_use_tags: false],
  output: [
    base_module: Esi.Api,
    location: "lib/esi/api",
    default_client: Esi.Client
  ]
]
```

### Testing

Run the comprehensive test suite:

```bash
# Run all tests
mix test

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

**Note**: This package is not officially supported or endorsed by CCP Games. It is a community-maintained utility for EVE Online developers.

