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

### dart.yml

GitHub Actions (`.github/workflows/dart.yml`): runs on push/PR to `main`. Uses local reusable pana workflow (`pana-dart.yaml`). Runs `dart format --set-exit-if-changed` and `dart analyze --fatal-infos` on every push. Builds `yt_js` (dart2js + tsup) and publishes to npm on `yt_js-v*` tags.

### homebrew-release.yml

GitHub Actions (`.github/workflows/homebrew-release.yml`): triggers on `yt_cli-v*` tags or manual `workflow_dispatch`. Compiles native binaries for macOS (ARM64 + x64) and Linux (x64), creates a GitHub Release with all binaries and a `checksums.txt` file, computes the source tarball SHA256, updates `homebrew/yt.rb` with the new version/URL/SHA256, and pushes the updated formula to the `cdavis-code/homebrew-yt` tap repository.

## Releasing yt_cli

The release process has three steps:

### 1. Publish to pub.dev (manual)

```sh
cd packages/yt_cli
dart pub publish
```

### 2. Trigger binary build + GitHub Release + Homebrew formula update (automatic)

Push a version tag matching `yt_cli-v*`:

```sh
git tag yt_cli-v2.2.7
git push origin yt_cli-v2.2.7
```

Or trigger manually via GitHub Actions > `Build and Release Homebrew Binaries` > `Run workflow`.

This triggers `.github/workflows/homebrew-release.yml` which:
- Compiles native binaries for macOS (ARM64 + x64) and Linux (x64) via `dart compile exe`
- Creates a GitHub Release on `cdavis-code/yt_workspace` with all binaries and a `checksums.txt`
- Computes the source tarball SHA256 and updates `homebrew/yt.rb` (version, URL, SHA256)
- Pushes the updated formula to the `cdavis-code/homebrew-yt` tap repository

No manual formula update is required — the workflow handles it automatically.

### 3. Update Homebrew formula (optional — manual fallback)

If the automated workflow fails or you need to update the formula manually:

```sh
# Via melos script
melos run homebrew

# Or directly
./tool/homebrew_release.sh

# Or by hand:
curl -sL https://github.com/cdavis-code/yt_workspace/archive/refs/tags/yt_cli-v2.2.7.tar.gz | shasum -a 256
# Update homebrew/yt.rb with new version, url, and sha256
cp homebrew/yt.rb ../homebrew-yt/Formula/yt.rb
cd ../homebrew-yt && git commit -am "yt_cli v2.2.7" && git push
```

Users install via `brew tap cdavis-code/yt && brew install yt`.

### Required secrets

Set in the GitHub repo under **Settings > Secrets and variables > Actions**:

| Secret | Purpose |
|--------|---------|
| `NPM_TOKEN` | npm access token with publish permissions for `@unngh/yt-js` |
| `HOMEBREW_TAP_TOKEN` | GitHub PAT with write access to `cdavis-code/homebrew-yt` (used by `homebrew-release.yml` to push formula updates) |
