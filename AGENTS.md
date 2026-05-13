# AGENTS.md - yt Workspace

## Project Overview

Dart monorepo (Dart SDK ^3.8.0) providing a native Dart interface to YouTube Data and Live Streaming APIs. Uses Dart workspaces + Melos for package management.

## Packages

| Package | Purpose |
|---------|---------|
| `packages/yt` | Core library - YouTube Data & Live Streaming APIs |
| `packages/yt_cli` | CLI tool for YouTube APIs |
| `packages/yt_js` | JS/TS bindings compiled via dart2js |
| `packages/yt_mcp` | MCP server for AI assistant integration |
| `packages/yt_mcp_js` | MCP server compiled to JavaScript for Node.js |

## Commands

```sh
# Setup
melos bootstrap              # Install all deps (recommended)
dart pub get                 # Manual alternative

# Code generation (yt: retrofit_generator, yt_mcp: easy_api_generator)
melos run build              # Runs build_runner where build.yaml exists

# Verify (run in this order)
melos run analyze            # dart analyze --fatal-infos
melos run format-check       # Check formatting
melos run lint:all           # analyze + format-check

# Tests
melos run test               # Runs dart test in packages with test/ dirs
```

## Key Conventions

- **Workspace resolution**: All packages use `resolution: workspace` in pubspec.yaml
- **Generated files**: `*.g.dart` (json_serializable/retrofit) and `*.mcp.dart` (MCP server) are excluded from analysis
- **yt_mcp codegen**: `easy_api_generator|mcpBuilder` generates from `lib/src/yt_mcp_server.dart`
- **yt codegen**: `retrofit_generator` and `json_serializable` via build_runner
- **yt_js/yt_mcp_js**: Excluded from `format-check` and `test` melos scripts
- **Melos concurrency**: Scripts run with `concurrency: 1` to avoid pub cache contention

## Analysis

- Includes `package:lints/recommended.yaml`
- Strict inference and raw types enabled
- Generated files excluded: `**/*.g.dart`, `**/*.mcp.dart`

## CI

GitHub Actions (`.github/workflows/dart.yml`): runs on push/PR to `main`. Uses pana workflow and basic `dart pub get`. Analyze and tests are commented out in CI.
