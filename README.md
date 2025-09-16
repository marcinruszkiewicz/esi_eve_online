# ESI Eve Online

A modern Elixir client for EVE Online's ESI (EVE Swagger Interface) API, designed to replace the unmaintained [esi](https://github.com/marcinruszkiewicz/esi) library with improved architecture, better maintainability, and modern Elixir practices.

## Migration Plan from Legacy ESI Library

This library is being developed as a drop-in replacement for the legacy `esi` library with significant improvements in architecture, maintainability, and developer experience.

### Current State Analysis

#### Legacy ESI Library (`/esi`)
- **Architecture**: Custom code generator with manual Swagger parsing
- **HTTP Client**: Hackney with custom request handling
- **JSON**: Poison for encoding/decoding
- **API Generation**: Custom generator (`ESI.Generator`) with manual module organization
- **Request Pattern**: `ESI.Request.t` struct → `ESI.request/2` → `{:ok, result} | {:error, reason}`
- **Key Features**:
  - Manual pagination support via `ESI.stream!/2`
  - Custom request validation
  - Manual error handling
  - 19 API modules with ~100+ endpoints
  - Elixir 1.4+ compatibility

#### New ESI Eve Online Library (`/esi_eve_online`)
- **Architecture**: OpenAPI Generator (`oapi_generator`) for automated code generation
- **HTTP Client**: Req (modern HTTP client)
- **JSON**: Jason (faster, more maintained)
- **API Generation**: Automated from OpenAPI 3.0 specification
- **Generated Files**: 321+ API modules with comprehensive endpoint coverage
- **Elixir**: 1.18+ (modern Elixir features)

### Migration Strategy

#### Phase 1: Core Infrastructure (Weeks 1-2)
**Status: ✅ COMPLETED**

1. **✅ Code Generation Setup**
   - OpenAPI generator configured with custom processor
   - 321 API endpoint modules generated
   - Custom naming conventions implemented
   - Comprehensive test coverage for naming logic

2. **✅ Request/Response Architecture**
   - Unified client interface (`Esi.Client`) similar to `ESI.request/2`
   - Standardized error handling across all endpoints (`Esi.Error`)
   - Main interface module (`EsiEveOnline`) with HTTP method shortcuts
   - Full integration with generated API modules

3. **✅ HTTP Client Integration**
   - Req client configured with ESI-specific defaults
   - Authentication handling (OAuth2 Bearer tokens)
   - Retry logic and rate limiting built-in
   - Proper headers (User-Agent, Accept, Content-Type)
   - Path parameter substitution and query handling

#### Phase 2: API Compatibility Layer (Weeks 3-4)

1. **🔄 Backward Compatibility Module**
   ```elixir
   # Legacy pattern support - works exactly like the old library
   ESI.API.Alliance.corporations(alliance_id) |> ESI.request()
   
   # New pattern (recommended)
   Esi.Api.Alliance.get_corporations(alliance_id)
   ```

2. **📋 Request Struct Migration**
   - Maintain `ESI.Request.t` compatibility
   - Map legacy request options to new client options
   - Preserve existing validation patterns

3. **🔄 Stream Support**
   - Implement `ESI.stream!/2` equivalent for pagination
   - Auto-detect paginated endpoints
   - Maintain lazy evaluation patterns

#### Phase 3: Enhanced Features (Weeks 5-6)

1. **🆕 Modern Elixir Features**
   - Leverage Req's built-in features (caching, retries, telemetry)
   - Implement proper typespec coverage
   - Add comprehensive documentation

2. **🔄 Developer Experience**
   - Better error messages with context
   - Improved debugging capabilities
   - Enhanced logging and telemetry

3. **📋 Testing & Quality**
   - Comprehensive test suite
   - Mock support for development
   - Performance benchmarks vs legacy library

#### Phase 4: Advanced Features (Weeks 7-8)

1. **🆕 Enhanced Pagination**
   ```elixir
   # Automatic pagination with streams
   Esi.Api.Universe.systems()
   |> Esi.stream!()
   |> Enum.take(1000)
   ```

2. **🔄 Caching & Performance**
   - Built-in response caching
   - ETags and conditional requests
   - Connection pooling optimization

3. **📋 Monitoring & Observability**
   - Telemetry events for all requests
   - Metrics collection
   - Error tracking and reporting

### Technical Implementation Details

#### 1. Client Architecture
```elixir
# Main unified interface (✅ IMPLEMENTED)
defmodule EsiEveOnline do
  # Direct HTTP interface
  def get(path, opts \\ [])
  def post(path, body, opts \\ [])
  def put(path, body, opts \\ [])
  def delete(path, opts \\ [])
  def patch(path, body, opts \\ [])
  
  # Bang versions (raise on error)
  def get!(path, opts \\ [])
  def post!(path, body, opts \\ [])
  # ... other bang methods
  
  # Direct client delegation
  def request(request_spec, opts \\ [])
end

# HTTP Client (✅ IMPLEMENTED)
defmodule Esi.Client do
  def request(request_spec, opts \\ [])
  # Handles authentication, retries, error processing
end

# Generated API modules (✅ IMPLEMENTED)
defmodule Esi.Api.Alliances do
  def alliance(alliance_id, opts \\ [])     # GET /alliances/{id}
  def alliances(opts \\ [])                # GET /alliances
end
```

#### 2. Authentication Handling (✅ IMPLEMENTED)
```elixir
# Token-based authentication (per-request)
opts = [token: "your_access_token"]
{:ok, assets} = Esi.Api.Characters.assets(character_id, opts)

# Custom options per request
opts = [
  token: "access_token",
  timeout: 60_000,
  retries: 5,
  user_agent: "MyApp/1.0 (contact@example.com)"
]
{:ok, result} = Esi.Api.Characters.mail(character_id, opts)
```

#### 3. Error Handling Strategy (✅ IMPLEMENTED)
```elixir
# Standardized error responses with comprehensive types
{:ok, data} | {:error, %Esi.Error{
  type: :http_error | :api_error | :validation_error | :network_error | :timeout_error,
  status: 404,
  message: "Character not found",
  details: %{...},
  request_id: "req-123",    # For debugging
  retry_after: 60          # For rate limiting
}}

# Specific error handling examples
case Esi.Api.Characters.character(invalid_id) do
  {:ok, character} -> handle_success(character)
  {:error, %Esi.Error{type: :api_error, status: 404}} -> handle_not_found()
  {:error, %Esi.Error{type: :api_error, status: 420, retry_after: seconds}} -> 
    schedule_retry(seconds)
  {:error, %Esi.Error{type: :timeout_error}} -> handle_timeout()
  {:error, error} -> handle_generic_error(error)
end
```

#### 4. Migration Path for Consumers
```elixir
# Step 1: Add new dependency alongside old one
def deps do
  [
    {:esi, git: "https://github.com/marcinruszkiewicz/esi.git"},
    {:esi_eve_online, "~> 1.0"}
  ]
end

# Step 2: Gradual migration with compatibility layer
# The library provides ESI and ESI.API modules for legacy compatibility
ESI.API.Character.character(character_id) |> ESI.request()

# Step 3: Move to new API patterns
EsiEveOnline.get("/characters/#{character_id}")
```

### Breaking Changes & Migration Guide

#### API Module Organization
- **Legacy**: `ESI.API.Alliance.corporations/1`
- **New**: `EsiEveOnline.get("/alliances/{alliance_id}/corporations")`
- **Migration**: Legacy `ESI.API.*` modules provided for compatibility

#### Request Options
- **Legacy**: Options passed to `ESI.request/2`
- **New**: Options passed to `EsiEveOnline.get/2` and similar functions
- **Migration**: Legacy `ESI.request/2` function still available

#### Response Format
- **Legacy**: Direct data return or `{:ok, data}` tuples
- **New**: Consistent `{:ok, data} | {:error, reason}` pattern
- **Migration**: Response normalization layer

### Success Metrics

1. **Compatibility**: 100% of legacy ESI functionality preserved
2. **Performance**: ≥20% improvement in request latency
3. **Maintainability**: Automated code generation from OpenAPI spec
4. **Coverage**: Support for all ESI endpoints (321+ vs legacy ~100)
5. **Developer Experience**: Improved documentation and error messages

### Timeline & Milestones

- **Week 1-2**: Core infrastructure and HTTP client setup
- **Week 3-4**: Backward compatibility layer implementation
- **Week 5-6**: Enhanced features and developer experience
- **Week 7-8**: Advanced features and performance optimization
- **Week 9**: Documentation, testing, and release preparation
- **Week 10**: Community feedback and final adjustments

### Risk Mitigation

1. **Compatibility Risk**: Extensive test suite covering legacy patterns
2. **Performance Risk**: Benchmarking against legacy library
3. **Adoption Risk**: Gradual migration path with compatibility layer
4. **Maintenance Risk**: Automated code generation reduces manual maintenance

## Installation

```elixir
def deps do
  [
    {:esi_eve_online, "~> 1.0"}
  ]
end
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

## Current Implementation Status

### ✅ Completed Features

- **🏗️ Core Infrastructure**: Complete HTTP client with Req, error handling, authentication
- **🎯 Smart Function Naming**: Semantic API function names with conflict resolution
- **🔧 Code Generation**: 321 API modules auto-generated from OpenAPI spec
- **🧪 Comprehensive Testing**: 56 tests covering all functionality
- **📚 Documentation**: Complete examples and usage patterns

### 🚀 Key Improvements Over Legacy Library

| Feature | Legacy ESI | New ESI Eve Online |
|---------|------------|-------------------|
| **HTTP Client** | Hackney | Modern Req with built-in retries |
| **JSON Library** | Poison | Jason (faster, better maintained) |
| **API Coverage** | ~100 endpoints | 321+ endpoints (complete coverage) |
| **Function Names** | Generic (`get`, `post`) | Semantic (`alliance`, `alliances`, `invite`) |
| **Error Handling** | Basic | Comprehensive with types and metadata |
| **Authentication** | Manual | Built-in OAuth2 Bearer token support |
| **Testing** | Limited | 56 comprehensive tests |
| **Maintenance** | Manual updates | Auto-generated from OpenAPI spec |

### 🎯 Function Naming Examples

The new library uses intelligent, semantic function names:

```elixir
# ❌ Old library (generic, confusing)
ESI.API.Alliance.alliance(alliance_id) |> ESI.request()        # Generic
ESI.API.Fleet.create_fleet_invitation(fleet_id, member_data) |> ESI.request()   # Verbose

# ✅ New library (semantic, clear)
Esi.Api.Alliances.alliance(alliance_id)      # Get alliance info
Esi.Api.Alliances.alliances()                # List all alliances  
Esi.Api.Fleets.invite(fleet_id, member_data) # Invite to fleet
```

### 📊 Test Coverage

- **Error Handling**: 12 tests covering all error types and scenarios
- **HTTP Client**: 32 tests covering requests, auth, retries, timeouts
- **Main Interface**: 12 tests covering unified HTTP methods
- **Integration**: 10 tests verifying end-to-end functionality
- **Custom Processor**: 12 tests ensuring correct function naming

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

# Run with integration tests
mix test --include integration

# Run specific test files
mix test test/esi/client_test.exs
mix test test/esi/custom_processor_test.exs
```

The test suite includes:
- **56 total tests** covering all functionality
- Unit tests for error handling, client, and main interface
- Integration tests verifying end-to-end API functionality
- Custom processor tests ensuring correct function naming
- Mock-based testing for reliable, fast execution

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

