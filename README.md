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
**Status: IN PROGRESS**

1. **✅ Code Generation Setup**
   - OpenAPI generator configured with custom processor
   - 321 API endpoint modules generated
   - Custom naming conventions implemented

2. **🔄 Request/Response Architecture**
   - Implement unified client interface similar to `ESI.request/2`
   - Create compatibility layer for existing request patterns
   - Standardize error handling across all endpoints

3. **📋 HTTP Client Integration**
   - Configure Req client with ESI-specific defaults
   - Implement authentication handling (OAuth2 tokens)
   - Add retry logic and rate limiting
   - Configure proper headers (User-Agent, Accept-Language, etc.)

#### Phase 2: API Compatibility Layer (Weeks 3-4)

1. **🔄 Backward Compatibility Module**
   ```elixir
   # Legacy pattern support
   ESI.API.Alliance.corporations(alliance_id) |> ESI.request()
   
   # New pattern (internal)
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
defmodule EsiEveOnline do
  # Main client interface - backward compatible
  def request(request_struct, opts \\ [])
  def request!(request_struct, opts \\ [])
  def stream!(request_struct, opts \\ [])
  
  # New direct interface
  def get(path, opts \\ [])
  def post(path, body, opts \\ [])
  # ... other HTTP methods
end
```

#### 2. Authentication Handling
```elixir
# Token-based authentication
opts = [token: "your_access_token"]
Esi.Api.Character.get_character_info(character_id, opts)

# Application-level configuration
config :esi_eve_online,
  user_agent: "MyApp/1.0 (foo@example.com; +https://github.com/your/repository) EsiEveOnline/0.1.0"
```

#### 3. Error Handling Strategy
```elixir
# Standardized error responses
{:ok, data} | {:error, %EsiEveOnline.Error{
  type: :http_error | :api_error | :validation_error,
  status: 404,
  message: "Character not found",
  details: %{...}
}}
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
alias EsiEveOnline.Legacy, as: ESI  # Drop-in replacement

# Step 3: Move to new API patterns
EsiEveOnline.Api.Character.get_character_info(character_id)
```

### Breaking Changes & Migration Guide

#### API Module Organization
- **Legacy**: `ESI.API.Alliance.corporations/1`
- **New**: `Esi.Api.Alliance.get_corporations/2`
- **Migration**: Compatibility aliases provided

#### Request Options
- **Legacy**: Options passed to `ESI.request/2`
- **New**: Options passed to individual endpoint functions
- **Migration**: Option mapping layer implemented

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

```elixir
# Get character information
{:ok, character} = EsiEveOnline.Api.Character.get_character_info(character_id)

# With authentication
{:ok, assets} = EsiEveOnline.Api.Character.get_assets(character_id, token: access_token)

# Stream paginated results
EsiEveOnline.Api.Universe.systems()
|> EsiEveOnline.stream!()
|> Enum.take(100)
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

