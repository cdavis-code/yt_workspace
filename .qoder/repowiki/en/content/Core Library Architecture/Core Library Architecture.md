# Core Library Architecture

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [pubspec.yaml](file://pubspec.yaml)
- [yt.dart](file://packages/yt/lib/yt.dart)
- [meta.dart](file://packages/yt/lib/meta.dart)
- [oauth.dart](file://packages/yt/lib/oauth.dart)
- [yt_base.dart](file://packages/yt/lib/src/yt_base.dart)
- [youtube_api_helper.dart](file://packages/yt/lib/src/youtube_api_helper.dart)
- [broadcast.dart](file://packages/yt/lib/src/broadcast.dart)
- [channels.dart](file://packages/yt/lib/src/channels.dart)
- [oauth_access_control_interface.dart](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart)
- [oauth_access_control_io.dart](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart)
- [oauth_access_control_web.dart](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart)
- [refresh_token_generator.dart](file://packages/yt/lib/src/oauth/refresh_token_generator.dart)
- [logging_interceptors.dart](file://packages/yt/lib/src/util/logging_interceptors.dart)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Core Components](#core-components)
4. [Architecture Overview](#architecture-overview)
5. [Detailed Component Analysis](#detailed-component-analysis)
6. [Dependency Analysis](#dependency-analysis)
7. [Performance Considerations](#performance-considerations)
8. [Troubleshooting Guide](#troubleshooting-guide)
9. [Conclusion](#conclusion)

## Introduction
This document describes the architecture of the core YouTube API Dart SDK library. The system centers on the Yt orchestrator class as the main entry point, providing a unified interface to multiple YouTube API modules (Data and Live Streaming). Authentication is handled via interceptors and platform-aware OAuth access control, while HTTP operations are delegated to a shared Dio client. The design leverages a base helper class for common API operations and follows a modular structure for maintainability and extensibility.

## Project Structure
The yt workspace is organized as a multi-package monorepo. The core library resides under packages/yt and exposes a cohesive API surface for YouTube Data and Live Streaming. Supporting packages include CLI, JavaScript bindings, and MCP servers. The core library exports module classes and models, while internal implementation details are organized under src/.

```mermaid
graph TB
subgraph "Workspace"
WS["yt_workspace<br/>pubspec.yaml"]
end
subgraph "Core Library (yt)"
YT_PKG["packages/yt"]
LIB["lib/yt.dart"]
SRC["lib/src/"]
META["lib/meta.dart"]
OAUTH["lib/oauth.dart"]
end
subgraph "Core Modules"
YT_BASE["src/yt_base.dart"]
API_HELPER["src/youtube_api_helper.dart"]
BROADCAST["src/broadcast.dart"]
CHANNELS["src/channels.dart"]
end
subgraph "OAuth & Platform"
OAUTH_IF["src/oauth/oauth_access_control_interface.dart"]
OAUTH_IO["src/oauth/oauth_access_control_io.dart"]
OAUTH_WEB["src/oauth/oauth_access_control_web.dart"]
RT_GEN["src/oauth/refresh_token_generator.dart"]
end
WS --> YT_PKG
YT_PKG --> LIB
YT_PKG --> META
YT_PKG --> OAUTH
YT_PKG --> SRC
SRC --> YT_BASE
SRC --> API_HELPER
SRC --> BROADCAST
SRC --> CHANNELS
SRC --> OAUTH_IF
OAUTH_IF --> OAUTH_IO
OAUTH_IF --> OAUTH_WEB
SRC --> RT_GEN
```

**Diagram sources**
- [pubspec.yaml:17-21](file://pubspec.yaml#L17-L21)
- [yt.dart:11-66](file://packages/yt/lib/yt.dart#L11-L66)
- [yt_base.dart:9-259](file://packages/yt/lib/src/yt_base.dart#L9-L259)
- [youtube_api_helper.dart:1-30](file://packages/yt/lib/src/youtube_api_helper.dart#L1-L30)
- [broadcast.dart:1-168](file://packages/yt/lib/src/broadcast.dart#L1-L168)
- [channels.dart:1-58](file://packages/yt/lib/src/channels.dart#L1-L58)
- [oauth_access_control_interface.dart:1-33](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L1-L33)
- [oauth_access_control_io.dart:1-80](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L1-L80)
- [oauth_access_control_web.dart:1-41](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L1-L41)
- [refresh_token_generator.dart:1-6](file://packages/yt/lib/src/oauth/refresh_token_generator.dart#L1-L6)

**Section sources**
- [README.md:8-18](file://README.md#L8-L18)
- [pubspec.yaml:17-21](file://pubspec.yaml#L17-L21)
- [yt.dart:11-66](file://packages/yt/lib/yt.dart#L11-L66)

## Core Components
- Yt orchestrator: Provides static factories for initialization (with API key, OAuth, or token generator), manages a shared Dio client, registers interceptors, and lazily instantiates API modules. It enforces capability checks for token-authenticated features and exposes getters for each module.
- YouTubeApiHelper base: Encapsulates common HTTP headers and part parameter building logic used by all API modules.
- Module classes: Specialized clients per YouTube endpoint (e.g., Broadcast, Channels) that delegate to generated provider clients and use the base helper for request construction.
- OAuth access control: Platform-aware strategy for managing tokens across native (IO) and web environments, with a refresh mechanism and credential persistence.
- Interceptors: Centralized logging and authentication interceptors applied to the shared Dio client.

Key implementation patterns:
- Strategy pattern for platform-specific OAuth implementations.
- Factory methods for flexible initialization and authentication modes.
- Shared HTTP client with layered interceptors for cross-cutting concerns.

**Section sources**
- [yt_base.dart:9-259](file://packages/yt/lib/src/yt_base.dart#L9-L259)
- [youtube_api_helper.dart:1-30](file://packages/yt/lib/src/youtube_api_helper.dart#L1-L30)
- [broadcast.dart:1-168](file://packages/yt/lib/src/broadcast.dart#L1-L168)
- [channels.dart:1-58](file://packages/yt/lib/src/channels.dart#L1-L58)
- [oauth_access_control_interface.dart:1-33](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L1-L33)
- [oauth_access_control_io.dart:1-80](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L1-L80)
- [oauth_access_control_web.dart:1-41](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L1-L41)
- [refresh_token_generator.dart:1-6](file://packages/yt/lib/src/oauth/refresh_token_generator.dart#L1-L6)

## Architecture Overview
The system architecture centers on the Yt orchestrator, which configures a shared Dio client and injects it into module classes. Authentication is enforced via interceptors that obtain and attach tokens using platform-aware OAuth access control. Module classes inherit common HTTP helpers and delegate to generated provider clients.

```mermaid
graph TB
subgraph "Application"
APP["Client Code"]
end
subgraph "Orchestrator"
YT["Yt<br/>static factories, interceptors, module getters"]
end
subgraph "HTTP Layer"
DIO["Dio Client"]
LOG_INT["Logging Interceptor"]
AUTH_INT["OAuth Interceptor"]
end
subgraph "Modules"
B["Broadcast"]
C["Channels"]
OTHERS["Other Modules..."]
end
subgraph "Base Helper"
BASE["YouTubeApiHelper<br/>headers, part builder"]
end
subgraph "OAuth Strategy"
IFACE["OAuthAccessControlInterface"]
IO["OAuthAccessControlIo"]
WEB["OAuthAccessControlWeb"]
GEN["RefreshTokenGenerator"]
end
APP --> YT
YT --> DIO
YT --> LOG_INT
YT --> AUTH_INT
DIO --> B
DIO --> C
DIO --> OTHERS
B --> BASE
C --> BASE
AUTH_INT --> IFACE
IFACE --> IO
IFACE --> WEB
YT --> GEN
```

**Diagram sources**
- [yt_base.dart:9-259](file://packages/yt/lib/src/yt_base.dart#L9-L259)
- [youtube_api_helper.dart:1-30](file://packages/yt/lib/src/youtube_api_helper.dart#L1-L30)
- [broadcast.dart:1-168](file://packages/yt/lib/src/broadcast.dart#L1-L168)
- [channels.dart:1-58](file://packages/yt/lib/src/channels.dart#L1-L58)
- [oauth_access_control_interface.dart:1-33](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L1-L33)
- [oauth_access_control_io.dart:1-80](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L1-L80)
- [oauth_access_control_web.dart:1-41](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L1-L41)
- [refresh_token_generator.dart:1-6](file://packages/yt/lib/src/oauth/refresh_token_generator.dart#L1-L6)

## Detailed Component Analysis

### Yt Orchestrator
Responsibilities:
- Initialize logging and interceptors.
- Provide factories for API key, OAuth, and token generator modes.
- Manage a shared Dio client and register interceptors.
- Lazily instantiate modules and expose getters with capability checks.
- Close the HTTP client when done.

Design decisions:
- Static Dio instance ensures a single HTTP pipeline across all modules.
- Interceptor registration supports both start and end positions for ordering control.
- Capability checks prevent invoking token-required features with API key mode.

```mermaid
classDiagram
class Yt {
+withApiKey(apiKey, additionalHeaders)
+withOAuth(oAuthClientId, logOptions)
+withGenerator(refreshTokenGenerator, logOptions)
+addInterceptor(interceptor, position)
+setModules(useTokenAuth, apiKey)
+close()
+broadcast
+channels
+chat
+comments
+commentThreads
+liveStream
+playlists
+playlistItems
+search
+subscriptions
+thumbnails
+videos
+videoCategories
+watermarks
}
class YouTubeApiHelper {
+buildParts(partList, part)
}
class Broadcast
class Channels
Yt --> Broadcast : "instantiates"
Yt --> Channels : "instantiates"
Broadcast --> YouTubeApiHelper : "extends"
Channels --> YouTubeApiHelper : "extends"
```

**Diagram sources**
- [yt_base.dart:9-259](file://packages/yt/lib/src/yt_base.dart#L9-L259)
- [youtube_api_helper.dart:1-30](file://packages/yt/lib/src/youtube_api_helper.dart#L1-L30)
- [broadcast.dart:1-168](file://packages/yt/lib/src/broadcast.dart#L1-L168)
- [channels.dart:1-58](file://packages/yt/lib/src/channels.dart#L1-L58)

**Section sources**
- [yt_base.dart:76-259](file://packages/yt/lib/src/yt_base.dart#L76-L259)

### OAuth Access Control Strategy
The OAuth subsystem uses a strategy pattern to select platform-specific implementations:
- Interface defines token access and lifecycle methods.
- IO implementation handles local credential storage and refresh.
- Web implementation obtains credentials via browser APIs.
- RefreshTokenGenerator enables external token provisioning.

```mermaid
classDiagram
class OAuthAccessControl {
<<interface>>
+token : String
+init() Future~void~
+checkAccessToken() Future~void~
}
class BaseOAuthAccessControl {
+clientId : ClientId?
+initialized : bool
+accessCredentials : AccessCredentials
+token : String
+init() Future~void~
+checkAccessToken() Future~void~
}
class OAuthAccessControlIo {
+init() Future~void~
+checkAccessToken() Future~void~
}
class OAuthAccessControlWeb {
+init() Future~void~
+checkAccessToken() Future~void~
}
class RefreshTokenGenerator {
<<interface>>
+generate() Future~Token~
}
OAuthAccessControl <|.. BaseOAuthAccessControl
BaseOAuthAccessControl <|-- OAuthAccessControlIo
BaseOAuthAccessControl <|-- OAuthAccessControlWeb
OAuthAccessControl --> OAuthAccessControlIo : "platform selection"
OAuthAccessControl --> OAuthAccessControlWeb : "platform selection"
```

**Diagram sources**
- [oauth_access_control_interface.dart:1-33](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L1-L33)
- [oauth_access_control_io.dart:1-80](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L1-L80)
- [oauth_access_control_web.dart:1-41](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L1-L41)
- [refresh_token_generator.dart:1-6](file://packages/yt/lib/src/oauth/refresh_token_generator.dart#L1-L6)

**Section sources**
- [oauth_access_control_interface.dart:7-33](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L7-L33)
- [oauth_access_control_io.dart:10-80](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L10-L80)
- [oauth_access_control_web.dart:6-41](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L6-L41)
- [refresh_token_generator.dart:1-6](file://packages/yt/lib/src/oauth/refresh_token_generator.dart#L1-L6)

### HTTP Client and Interceptors
- Logging interceptor is registered by the orchestrator for observability.
- Authentication interceptor attaches Bearer tokens using OAuth access control or a provided token generator.
- All modules share the same Dio client, ensuring consistent headers, timeouts, and retry policies.

```mermaid
sequenceDiagram
participant App as "Client Code"
participant Yt as "Yt"
participant Dio as "Dio"
participant AuthInt as "OAuth Interceptor"
participant OA as "OAuthAccessControl"
participant Mod as "Module (e.g., Broadcast)"
participant Provider as "Generated Client"
App->>Yt : "withOAuth()/withApiKey()/withGenerator()"
Yt->>Dio : "configure client and interceptors"
App->>Mod : "invoke operation"
Mod->>Dio : "send request"
Dio->>AuthInt : "onRequest"
AuthInt->>OA : "checkAccessToken()"
OA-->>AuthInt : "token"
AuthInt->>Dio : "attach Authorization header"
Dio->>Provider : "forward request"
Provider-->>Dio : "response"
Dio-->>Mod : "response"
Mod-->>App : "result"
```

**Diagram sources**
- [yt_base.dart:109-141](file://packages/yt/lib/src/yt_base.dart#L109-L141)
- [oauth_access_control_interface.dart:10-16](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L10-L16)
- [oauth_access_control_io.dart:33-78](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L33-L78)
- [oauth_access_control_web.dart:14-39](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L14-L39)
- [broadcast.dart:12-37](file://packages/yt/lib/src/broadcast.dart#L12-L37)

**Section sources**
- [yt_base.dart:171-185](file://packages/yt/lib/src/yt_base.dart#L171-L185)
- [logging_interceptors.dart](file://packages/yt/lib/src/util/logging_interceptors.dart)

### Module Classes and Generated Providers
Each module extends the base helper and delegates to a generated provider client. The base helper centralizes:
- Accept and content-type headers.
- Part parameter normalization and deduplication.

```mermaid
classDiagram
class YouTubeApiHelper {
+accept : String
+contentType : String
+buildParts(partList, part) String
}
class Broadcast {
+list(...)
+insert(...)
+update(...)
+transition(...)
+bind(...)
+delete(...)
+getActiveBroadcast()
+getUpcomingAndActiveBroadcast()
}
class Channels {
+list(...)
+update(...)
}
Broadcast --> YouTubeApiHelper : "extends"
Channels --> YouTubeApiHelper : "extends"
```

**Diagram sources**
- [youtube_api_helper.dart:1-30](file://packages/yt/lib/src/youtube_api_helper.dart#L1-L30)
- [broadcast.dart:1-168](file://packages/yt/lib/src/broadcast.dart#L1-L168)
- [channels.dart:1-58](file://packages/yt/lib/src/channels.dart#L1-L58)

**Section sources**
- [youtube_api_helper.dart:14-28](file://packages/yt/lib/src/youtube_api_helper.dart#L14-L28)
- [broadcast.dart:12-166](file://packages/yt/lib/src/broadcast.dart#L12-L166)
- [channels.dart:12-56](file://packages/yt/lib/src/channels.dart#L12-L56)

## Dependency Analysis
High-level dependencies:
- Yt depends on Dio, OAuth access control, and logging utilities.
- Module classes depend on the base helper and generated provider clients.
- OAuth access control selects platform-specific implementations at runtime.
- Interceptors depend on OAuth access control and the shared Dio client.

```mermaid
graph LR
YT["Yt"] --> DIO["Dio"]
YT --> LOGINT["Logging Interceptor"]
YT --> AUTHINT["OAuth Interceptor"]
AUTHINT --> OACL["OAuthAccessControl"]
OACL --> OACL_IO["OAuthAccessControlIo"]
OACL --> OACL_WEB["OAuthAccessControlWeb"]
MOD_B["Broadcast"] --> BASE["YouTubeApiHelper"]
MOD_C["Channels"] --> BASE
MOD_B --> DIO
MOD_C --> DIO
```

**Diagram sources**
- [yt_base.dart:9-259](file://packages/yt/lib/src/yt_base.dart#L9-L259)
- [oauth_access_control_interface.dart:1-33](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L1-L33)
- [oauth_access_control_io.dart:1-80](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L1-L80)
- [oauth_access_control_web.dart:1-41](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L1-L41)
- [broadcast.dart:1-168](file://packages/yt/lib/src/broadcast.dart#L1-L168)
- [channels.dart:1-58](file://packages/yt/lib/src/channels.dart#L1-L58)
- [youtube_api_helper.dart:1-30](file://packages/yt/lib/src/youtube_api_helper.dart#L1-L30)

**Section sources**
- [yt_base.dart:109-141](file://packages/yt/lib/src/yt_base.dart#L109-L141)
- [oauth_access_control_interface.dart:10-16](file://packages/yt/lib/src/oauth/oauth_access_control_interface.dart#L10-L16)

## Performance Considerations
- Single Dio client reduces overhead and enables consistent caching and retry policies.
- Interceptor ordering matters; place logging at the end to avoid redundant logs and ensure accurate timings.
- Token refresh occurs on demand; cache results appropriately to minimize repeated network calls.
- Use part parameters efficiently to limit payload sizes and reduce bandwidth usage.
- Avoid unnecessary module instantiation; rely on lazy getters to defer creation until needed.

## Troubleshooting Guide
Common issues and resolutions:
- Missing token in token-authenticated operations: Ensure OAuth initialization or token generator is configured before invoking token-required modules.
- Expired or invalid credentials: The OAuth access control automatically refreshes tokens; verify platform-specific credential storage and scopes.
- API key limitations: Some features require OAuth; capability checks will throw exceptions when using API key mode.
- Logging and diagnostics: Enable logging interceptor to inspect requests and responses; adjust log levels as needed.

**Section sources**
- [yt_base.dart:16-17](file://packages/yt/lib/src/yt_base.dart#L16-L17)
- [yt_base.dart:34-74](file://packages/yt/lib/src/yt_base.dart#L34-L74)
- [oauth_access_control_io.dart:33-78](file://packages/yt/lib/src/oauth/oauth_access_control_io.dart#L33-L78)
- [oauth_access_control_web.dart:14-39](file://packages/yt/lib/src/oauth/oauth_access_control_web.dart#L14-L39)

## Conclusion
The core library architecture centers on a clean separation of concerns: Yt orchestrates initialization and HTTP configuration, modules encapsulate endpoint-specific logic, and OAuth access control provides platform-aware authentication. This design yields a maintainable, extensible, and efficient SDK for interacting with YouTube APIs across Dart platforms.