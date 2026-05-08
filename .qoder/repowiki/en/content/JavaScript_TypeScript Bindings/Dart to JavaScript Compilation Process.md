# Dart to JavaScript Compilation Process

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [.github/workflows/dart.yml](file://.github/workflows/dart.yml)
- [pubspec.yaml](file://pubspec.yaml)
- [packages/yt_js/pubspec.yaml](file://packages/yt_js/pubspec.yaml)
- [packages/yt_js/package.json](file://packages/yt_js/package.json)
- [packages/yt_js/scripts/build.sh](file://packages/yt_js/scripts/build.sh)
- [packages/yt_js/tsup.config.ts](file://packages/yt_js/tsup.config.ts)
- [packages/yt_js/lib/yt_js.dart](file://packages/yt_js/lib/yt_js.dart)
- [packages/yt_js/lib/src/js_bindings.dart](file://packages/yt_js/lib/src/js_bindings.dart)
- [packages/yt_js/src/index.ts](file://packages/yt_js/src/index.ts)
- [packages/yt_js/src/browser.ts](file://packages/yt_js/src/browser.ts)
- [packages/yt_js/src/node.ts](file://packages/yt_js/src/node.ts)
- [packages/yt_js/src/runtime.ts](file://packages/yt_js/src/runtime.ts)
- [packages/yt_js/src/types.ts](file://packages/yt_js/src/types.ts)
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
10. [Appendices](#appendices)

## Introduction
This document explains the Dart to JavaScript compilation process used by the yt_js package. It covers the dart2js compilation pipeline, optimization flags, and build configuration options. It also documents how Dart source maps to the generated JavaScript output, how code splitting and tree shaking considerations apply, and provides guidance for build optimization, bundle size reduction, and development versus production builds. Finally, it includes troubleshooting tips, debugging compiled JavaScript, maintaining compatibility across JavaScript environments, and integrating with build tools, CI/CD, and automated deployment.

## Project Structure
The yt_js package is a dual-target distribution (browser and Node.js) produced by compiling a small Dart entry point to JavaScript via dart2js and then wrapping it with TypeScript/TSup. The build pipeline consists of:
- A Dart entry point that installs a global interoperability namespace.
- A dart2js step that compiles the Dart module to a JavaScript ES module.
- A TypeScript/TSup step that bundles browser and Node.js variants, exposes type declarations, and wires runtime loading.

```mermaid
graph TB
subgraph "Dart Sources"
DEntry["lib/yt_js.dart"]
DBind["lib/src/js_bindings.dart"]
end
subgraph "Build Tools"
Dart2js["dart compile js<br/>optimization: -O4"]
Tsup["tsup<br/>browser ESM, node ESM+CJS"]
end
subgraph "Outputs"
DartOut["build/dart/yt_js.js"]
Dist["dist/*.js, *.cjs, *.d.ts"]
end
DEntry --> DBind
DEntry --> Dart2js
DBind --> Dart2js
Dart2js --> DartOut
DartOut --> Tsup
Tsup --> Dist
```

**Diagram sources**
- [packages/yt_js/lib/yt_js.dart:1-14](file://packages/yt_js/lib/yt_js.dart#L1-L14)
- [packages/yt_js/lib/src/js_bindings.dart:1-187](file://packages/yt_js/lib/src/js_bindings.dart#L1-L187)
- [packages/yt_js/scripts/build.sh:18-22](file://packages/yt_js/scripts/build.sh#L18-L22)
- [packages/yt_js/tsup.config.ts:3-34](file://packages/yt_js/tsup.config.ts#L3-L34)
- [packages/yt_js/package.json:23-44](file://packages/yt_js/package.json#L23-L44)

**Section sources**
- [README.md:43-47](file://README.md#L43-L47)
- [packages/yt_js/package.json:1-69](file://packages/yt_js/package.json#L1-L69)
- [packages/yt_js/pubspec.yaml:1-19](file://packages/yt_js/pubspec.yaml#L1-L19)

## Core Components
- Dart entry point: Initializes the Dart-to-JavaScript interoperability by invoking the installation routine that exposes a global namespace.
- Dart interop bindings: Exposes a minimal, Promise-returning surface to JavaScript, forwarding to the yt Dart library and converting JSON responses.
- TypeScript runtime loader: Provides a platform-specific loader that dynamically imports the dart2js output and caches the installed namespace.
- Browser and Node entrypoints: Wrap the base API and inject platform-specific loaders (Node polyfills self/window before loading).
- TSup configuration: Produces browser-only ESM and Node ESM/CJS bundles, plus shared type declarations.

**Section sources**
- [packages/yt_js/lib/yt_js.dart:1-14](file://packages/yt_js/lib/yt_js.dart#L1-L14)
- [packages/yt_js/lib/src/js_bindings.dart:1-187](file://packages/yt_js/lib/src/js_bindings.dart#L1-L187)
- [packages/yt_js/src/runtime.ts:1-28](file://packages/yt_js/src/runtime.ts#L1-L28)
- [packages/yt_js/src/browser.ts:1-36](file://packages/yt_js/src/browser.ts#L1-L36)
- [packages/yt_js/src/node.ts:1-51](file://packages/yt_js/src/node.ts#L1-L51)
- [packages/yt_js/tsup.config.ts:1-35](file://packages/yt_js/tsup.config.ts#L1-L35)

## Architecture Overview
The compilation and packaging architecture is a two-stage process: Dart to JavaScript followed by TypeScript/TSup bundling.

```mermaid
sequenceDiagram
participant Dev as "Developer"
participant DartSDK as "Dart SDK (dart2js)"
participant DartOut as "build/dart/yt_js.js"
participant Loader as "runtime.ts loader"
participant TS as "tsup config"
participant Dist as "dist/*"
Dev->>DartSDK : "dart compile js -O4 lib/yt_js.dart"
DartSDK-->>DartOut : "emit ES module"
Dev->>TS : "tsup build"
TS->>Loader : "bundle runtime.ts + browser.ts/node.ts"
Loader->>DartOut : "dynamic import ../build/dart/yt_js.js"
DartOut-->>Loader : "install global YtJs namespace"
TS-->>Dist : "emit browser ESM, node ESM+CJS, d.ts"
```

**Diagram sources**
- [packages/yt_js/scripts/build.sh:18-22](file://packages/yt_js/scripts/build.sh#L18-L22)
- [packages/yt_js/src/runtime.ts:13-27](file://packages/yt_js/src/runtime.ts#L13-L27)
- [packages/yt_js/tsup.config.ts:3-34](file://packages/yt_js/tsup.config.ts#L3-L34)
- [packages/yt_js/package.json:23-44](file://packages/yt_js/package.json#L23-L44)

## Detailed Component Analysis

### Dart Entry Point and Interop Namespace
- The Dart entry point delegates to an installation routine that creates a global namespace with Promise-returning methods and a version marker.
- The interop layer converts Dart values to JSON and back to JavaScript for safe interop.

```mermaid
flowchart TD
Start(["Dart main()"]) --> Install["Install global namespace<br/>withApiKey, withOAuth, version"]
Install --> Expose["Expose Promise-returning methods<br/>and close()"]
Expose --> Convert["Convert Dart JSON to JS via JSON.parse"]
Convert --> End(["Global YtJs ready"])
```

**Diagram sources**
- [packages/yt_js/lib/yt_js.dart:11-13](file://packages/yt_js/lib/yt_js.dart#L11-L13)
- [packages/yt_js/lib/src/js_bindings.dart:19-25](file://packages/yt_js/lib/src/js_bindings.dart#L19-L25)
- [packages/yt_js/lib/src/js_bindings.dart:182-186](file://packages/yt_js/lib/src/js_bindings.dart#L182-L186)

**Section sources**
- [packages/yt_js/lib/yt_js.dart:1-14](file://packages/yt_js/lib/yt_js.dart#L1-L14)
- [packages/yt_js/lib/src/js_bindings.dart:1-187](file://packages/yt_js/lib/src/js_bindings.dart#L1-L187)

### TypeScript Runtime Loader and Platform Entrypoints
- The runtime loader accepts a platform-specific loader function, ensures the Dart runtime is loaded, and returns the installed namespace.
- Browser entrypoint dynamically imports the dart2js output and re-exports the public API.
- Node entrypoint polyfills self/window before importing the dart2js output.

```mermaid
sequenceDiagram
participant User as "User Code"
participant API as "src/index.ts Yt"
participant Loader as "src/runtime.ts getRuntime"
participant Dyn as "Dynamic Import"
participant Dart as "build/dart/yt_js.js"
User->>API : "Yt.withApiKey(...)"
API->>Loader : "getRuntime(loadDart)"
Loader->>Dyn : "await loader()"
Dyn->>Dart : "import('../build/dart/yt_js.js')"
Dart-->>Dyn : "installs global YtJs"
Dyn-->>Loader : "namespace available"
Loader-->>API : "return YtJsNamespace"
API-->>User : "return typed handle"
```

**Diagram sources**
- [packages/yt_js/src/index.ts:19-57](file://packages/yt_js/src/index.ts#L19-L57)
- [packages/yt_js/src/runtime.ts:13-27](file://packages/yt_js/src/runtime.ts#L13-L27)
- [packages/yt_js/src/browser.ts:17-20](file://packages/yt_js/src/browser.ts#L17-L20)
- [packages/yt_js/src/node.ts:19-23](file://packages/yt_js/src/node.ts#L19-L23)

**Section sources**
- [packages/yt_js/src/runtime.ts:1-28](file://packages/yt_js/src/runtime.ts#L1-L28)
- [packages/yt_js/src/browser.ts:1-36](file://packages/yt_js/src/browser.ts#L1-L36)
- [packages/yt_js/src/node.ts:1-51](file://packages/yt_js/src/node.ts#L1-L51)

### Build Configuration and Optimization Flags
- dart2js optimization: The build script compiles with a high optimization level suitable for production distribution.
- TSup targets: Browser bundle targets modern ES modules; Node bundle targets Node 18 with both ESM and CJS outputs.
- Exports and types: The package exports separate entrypoints for browser and Node, and ships TypeScript declaration files.

```mermaid
flowchart TD
A["Dart source"] --> B["dart compile js -O4"]
B --> C["build/dart/yt_js.js"]
C --> D["tsup browser ESM"]
C --> E["tsup node ESM+CJS"]
D --> F["dist/browser.js + d.ts"]
E --> G["dist/node.js + node.cjs + d.ts"]
```

**Diagram sources**
- [packages/yt_js/scripts/build.sh:18-22](file://packages/yt_js/scripts/build.sh#L18-L22)
- [packages/yt_js/tsup.config.ts:3-34](file://packages/yt_js/tsup.config.ts#L3-L34)
- [packages/yt_js/package.json:27-44](file://packages/yt_js/package.json#L27-L44)

**Section sources**
- [packages/yt_js/scripts/build.sh:1-32](file://packages/yt_js/scripts/build.sh#L1-L32)
- [packages/yt_js/tsup.config.ts:1-35](file://packages/yt_js/tsup.config.ts#L1-L35)
- [packages/yt_js/package.json:1-69](file://packages/yt_js/package.json#L1-L69)

### Relationship Between Dart Source and Generated JavaScript
- The Dart entry point triggers installation of a global namespace that mirrors the public API surface.
- The interop layer translates method calls and JSON payloads between Dart and JavaScript.
- The TypeScript layer provides a typed façade and defers to the runtime loader for the Dart-backed implementation.

```mermaid
classDiagram
class DartEntrypoint {
+main()
}
class JsInterop {
+install()
+_withApiKey()
+_withOAuth()
+_wrap()
}
class DartRuntime {
+globalThis.YtJs
}
class TypescriptFacade {
+Yt.withApiKey()
+Yt.withOAuth()
+Yt.searchList()
+Yt.channelsList()
+Yt.videosList()
+Yt.playlistsList()
+Yt.close()
}
DartEntrypoint --> JsInterop : "calls install()"
JsInterop --> DartRuntime : "sets global YtJs"
TypescriptFacade --> DartRuntime : "loads via loader"
```

**Diagram sources**
- [packages/yt_js/lib/yt_js.dart:11-13](file://packages/yt_js/lib/yt_js.dart#L11-L13)
- [packages/yt_js/lib/src/js_bindings.dart:19-25](file://packages/yt_js/lib/src/js_bindings.dart#L19-L25)
- [packages/yt_js/src/index.ts:19-123](file://packages/yt_js/src/index.ts#L19-L123)
- [packages/yt_js/src/runtime.ts:13-27](file://packages/yt_js/src/runtime.ts#L13-L27)

**Section sources**
- [packages/yt_js/lib/src/js_bindings.dart:1-187](file://packages/yt_js/lib/src/js_bindings.dart#L1-L187)
- [packages/yt_js/src/index.ts:1-124](file://packages/yt_js/src/index.ts#L1-L124)

### Code Splitting and Tree Shaking Considerations
- Dynamic import in the browser entrypoint allows bundlers to split the dart2js runtime into a separate chunk.
- The Node entrypoint polyfills environment globals before loading the runtime, ensuring compatibility.
- TSup produces separate bundles per platform; unused parts of the Dart runtime are not automatically removed but the dynamic import enables lazy loading.

```mermaid
flowchart TD
Start(["Import '@unngh/yt-js'"]) --> Check["Check platform"]
Check --> |Browser| LoadB["@unngh/yt-js/browser"]
Check --> |Node| LoadN["@unngh/yt-js/node"]
LoadB --> DynImpB["Dynamic import '../build/dart/yt_js.js'"]
LoadN --> Polyfill["Ensure self/window"]
Polyfill --> DynImpN["Dynamic import '../build/dart/yt_js.js'"]
DynImpB --> Ready["Use typed API"]
DynImpN --> Ready
```

**Diagram sources**
- [packages/yt_js/src/browser.ts:17-20](file://packages/yt_js/src/browser.ts#L17-L20)
- [packages/yt_js/src/node.ts:13-23](file://packages/yt_js/src/node.ts#L13-L23)
- [packages/yt_js/package.json:27-44](file://packages/yt_js/package.json#L27-L44)

**Section sources**
- [packages/yt_js/src/browser.ts:1-36](file://packages/yt_js/src/browser.ts#L1-L36)
- [packages/yt_js/src/node.ts:1-51](file://packages/yt_js/src/node.ts#L1-L51)
- [packages/yt_js/package.json:1-69](file://packages/yt_js/package.json#L1-L69)

## Dependency Analysis
- Dart dependencies: The Dart interop depends on the yt core library and logging utilities.
- NPM dependencies: The package depends on the yt Dart package and web support; dev dependencies include TSup, TypeScript, and testing utilities.
- Build orchestration: The build script runs dart pub get and dart compile js, then copies the runtime into dist for resolution by TSup.

```mermaid
graph LR
Pkg["yt_js pubspec.yaml"] --> DartDep["yt ^2.2.6"]
Pkg --> WebDep["web ^1.1.0"]
Pkg --> Loggy["loggy ^2.0.3"]
NPM["package.json"] --> TSup["tsup"]
NPM --> TS["typescript"]
NPM --> Vitest["vitest"]
NPM --> Happy["happy-dom"]
```

**Diagram sources**
- [packages/yt_js/pubspec.yaml:12-16](file://packages/yt_js/pubspec.yaml#L12-L16)
- [packages/yt_js/package.json:53-59](file://packages/yt_js/package.json#L53-L59)

**Section sources**
- [packages/yt_js/pubspec.yaml:1-19](file://packages/yt_js/pubspec.yaml#L1-L19)
- [packages/yt_js/package.json:1-69](file://packages/yt_js/package.json#L1-L69)

## Performance Considerations
- Use the highest optimization level appropriate for production distributions. The build script uses a high optimization flag suitable for production.
- Keep the Dart interop surface minimal to reduce overhead and improve tree-shaking in downstream bundlers.
- Prefer dynamic imports for heavy runtime code to enable lazy loading and smaller initial payloads.
- Monitor bundle sizes and adjust TSup targets and externalization strategies as needed.

[No sources needed since this section provides general guidance]

## Troubleshooting Guide
Common issues and resolutions:
- Global namespace not installed: Ensure the runtime loader is invoked and the dynamic import resolves to the compiled Dart module. The loader throws a clear error if the namespace is missing.
- Node environment errors: The Node entrypoint polyfills self and window before loading the runtime; confirm these globals are available.
- Missing exports or wrong entrypoint: Verify the package exports and entrypoints match the intended consumption model (browser vs Node).
- CI/CD failures: The workflow installs dependencies and runs the Dart analyzer; ensure the environment matches the workflow’s expectations.

**Section sources**
- [packages/yt_js/src/runtime.ts:19-24](file://packages/yt_js/src/runtime.ts#L19-L24)
- [packages/yt_js/src/node.ts:13-17](file://packages/yt_js/src/node.ts#L13-L17)
- [packages/yt_js/package.json:27-44](file://packages/yt_js/package.json#L27-L44)
- [.github/workflows/dart.yml:30-39](file://.github/workflows/dart.yml#L30-L39)

## Conclusion
The yt_js package combines a compact Dart interop layer compiled to JavaScript with a TypeScript façade and platform-specific loaders. The build pipeline leverages dart2js for a production-ready runtime and TSup for multi-format distribution. By keeping the interop surface minimal, using dynamic imports for code splitting, and configuring TSup appropriately, the package achieves efficient distribution across browsers and Node.js while maintaining a typed, ergonomic API.

[No sources needed since this section summarizes without analyzing specific files]

## Appendices

### Build Commands and Scripts
- Build the Dart runtime: runs the build script that compiles the Dart entry point with dart2js.
- Build TypeScript bundles: runs TSup to produce browser and Node bundles with source maps and type declarations.
- Clean artifacts: removes build and dist directories.

**Section sources**
- [packages/yt_js/package.json:60-67](file://packages/yt_js/package.json#L60-L67)
- [packages/yt_js/scripts/build.sh:1-32](file://packages/yt_js/scripts/build.sh#L1-L32)

### CI/CD and Automation
- The workflow installs the Dart SDK, fetches dependencies, and optionally runs analysis and tests. Adapt steps as needed for your CI environment.

**Section sources**
- [.github/workflows/dart.yml:1-46](file://.github/workflows/dart.yml#L1-L46)