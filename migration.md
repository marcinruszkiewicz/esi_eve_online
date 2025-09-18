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

