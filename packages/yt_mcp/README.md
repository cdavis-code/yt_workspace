# yt_mcp

![yt_mcp banner](https://raw.githubusercontent.com/cdavis-code/yt_workspace/refs/heads/main/packages/yt_mcp/images/banner.svg)

<p align="center">
  <strong>MCP Server for YouTube APIs</strong><br/>
  AI-Ready YouTube Tools • Built with Dart • 90+ MCP Tools • 26 API Services
</p>

<p align="center">
  <a href="https://pub.dev/packages/yt_mcp"><img src="https://img.shields.io/pub/v/yt_mcp.svg?label=pub.dev&labelColor=333940&logo=dart&logoColor=fff" alt="Pub"></a>
  <a href="https://github.com/cdavis-code/yt_workspace"><img src="https://img.shields.io/github/stars/cdavis-code/yt_workspace?label=stars&logo=github&labelColor=333940" alt="GitHub stars"></a>
  <a href="https://pub.dev/packages/skills"><img src="https://img.shields.io/badge/AI%20Agent%20Skill-included-00b4ab?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTEyIDJMMTMuMDkgOC4yNkwyMCA5TDEzLjA5IDE1Ljc0TDE1IDIyTDEyIDE4Ljc3TDkgMjJMMSAuOTkgMTcuNzRMNSAxNUwtMiA5TDUgOC4yNkwxMiAyWiIvPjwvc3ZnPg==" alt="AI Agent Skill"></a>
</p>

---

A standalone MCP (Model Context Protocol) server for the YouTube Data API v3 and Live Streaming API. Built on top of the [`yt`](https://pub.dev/packages/yt) Dart library, it exposes YouTube operations as MCP tools over stdio transport for AI assistants and LLM integration.

## Table of Contents

- [What's New](#whats-new)
- [Quick Start](#quick-start)
- [MCP Host Configuration](#mcp-host-configuration)
  - [Qoder](#qoder)
  - [Claude Desktop](#claude-desktop)
  - [VS Code](#vs-code)
- [Available Tools](#available-tools)
- [Configuration](#configuration)
- [Development Setup](#development-setup)
- [Testing with MCP Inspector](#testing-with-mcp-inspector)
- [License](#license)

## What's New

This release expands yt_mcp to **full feature parity** with the underlying `yt` library:

- **90+ MCP tools** across all 26 YouTube API services
- **Complete CRUD operations**: Create, update, and delete videos, playlists, comments, subscriptions
- **Live Streaming**: Full broadcast/stream lifecycle management, live chat, cuepoints
- **Analytics**: Reports, groups, and group items management
- **Media Uploads**: Video upload, caption management, thumbnail/watermark uploads
- **Content Management**: Video ratings, abuse reporting, moderation controls

## Quick Start

**For end-users:** Choose between global Dart activation (Option 1) or Homebrew installation (Option 2). Both make the `yt_mcp` command available on your PATH for use with AI agents like Qoder, Claude Desktop, or VS Code.

**For developers:** If you need to modify the source code or add new tools, see the [Development Setup](#development-setup) section below.

### Option 1: Global Dart Activation

```bash
# Activate the package globally (makes the 'yt_mcp' command available)
dart pub global activate yt_mcp

# For read-only access (API key):
export YT_API_KEY="your-api-key-here"

# OR for full access (OAuth - file-based credentials):
export YT_CLIENT_SECRETS_FILE="path/to/client_secrets.json"
export YT_ACCESS_TOKENS_FILE="path/to/access_tokens.json"
```

### Option 2: Homebrew Installation (macOS/Linux)

```bash
# Tap the Homebrew repository
brew tap cdavis-code/yt

# Install yt_mcp
brew install yt-mcp

# Verify installation
yt_mcp --help

# Configure credentials (same as Option 1)
export YT_API_KEY="your-api-key-here"
# OR for OAuth:
export YT_CLIENT_SECRETS_FILE="path/to/client_secrets.json"
export YT_ACCESS_TOKENS_FILE="path/to/access_tokens.json"
```

That's it! Configure your AI agent using one of the [MCP Host Configuration](#mcp-host-configuration) examples below, and the agent will launch the server automatically.

## Available Tools

All tools are organized into the following service groups:

| Group | Key Tools | Description |
|---|---|---|
| **Search** | `search_list` | Search videos, channels, playlists by query |
| **Videos** | `videos_list`, `videos_insert`, `videos_update`, `videos_rate`, `videos_delete` | Video CRUD, ratings, uploads |
| **Channels** | `channels_list`, `channels_listMine`, `channels_update` | Channel details and updates |
| **Playlists** | `playlists_list`, `playlists_insert`, `playlists_update`, `playlists_delete` | Playlist lifecycle management |
| **Playlist Items** | `playlist_items_list`, `playlist_items_insert`, `playlist_items_update`, `playlist_items_delete` | Add/remove videos from playlists |
| **Comments** | `comments_list`, `comments_insert`, `comments_update`, `comments_setModerationStatus`, `comments_delete` | Full comment management and moderation |
| **Comment Threads** | `comment_threads_list`, `comment_threads_insert` | Thread-based comment operations |
| **Subscriptions** | `subscriptions_list`, `subscriptions_insert`, `subscriptions_delete` | Channel subscription management |
| **Live Broadcasts** | `broadcasts_list`, `broadcasts_insert`, `broadcasts_update`, `broadcasts_transition`, `broadcasts_bind`, `broadcasts_delete` | Broadcast lifecycle and transitions |
| **Live Streams** | `live_streams_list`, `live_streams_insert`, `live_streams_update`, `live_streams_delete` | Stream configuration management |
| **Live Chat** | `live_chat_list`, `live_chat_insert`, `live_chat_delete` | Live chat message operations |
| **Analytics** | `analytics_query`, `analytics_groupsList`, `analytics_groupsInsert`, `analytics_groupsUpdate`, `analytics_groupsDelete` | YouTube Analytics reports and groups |
| **Captions** | `captions_list`, `captions_insert`, `captions_update`, `captions_download`, `captions_delete` | Caption track management |
| **Thumbnails** | `thumbnails_set` | Upload video thumbnails |
| **Watermarks** | `watermarks_set`, `watermarks_unset` | Channel watermark management |
| **Channel Banners** | `channel_banners_insert` | Upload channel banner images |
| **Channel Sections** | `channel_sections_list`, `channel_sections_insert`, `channel_sections_update`, `channel_sections_delete` | Channel page sections |
| **Activities** | `activities_list` | Channel activity feed |
| **Video Categories** | `video_categories_list` | YouTube video category listings |
| **I18n** | `i18n_languages_list`, `i18n_regions_list` | Internationalization data |
| **Playlist Images** | `playlist_images_list`, `playlist_images_insert`, `playlist_images_update`, `playlist_images_delete` | Playlist image management |
| **Third-Party Links** | `third_party_links_list`, `third_party_links_insert`, `third_party_links_update`, `third_party_links_delete` | Channel third-party link management |

## Configuration

### Authentication

Environment variables can be set via the shell or a `.env` file. The server searches for `.env` in the following locations (in order): `.env`, `bin/.env`, or adjacent to the running script.

| Variable | Description | Required For |
|---|---|---|
| `YT_API_KEY` | YouTube Data API key | Read-only public data (search, video details, etc.) |
| `YT_CLIENT_SECRETS_FILE` | Path to OAuth client secrets JSON file | OAuth authentication (uploads, updates, deletes, live streaming) |
| `YT_ACCESS_TOKENS_FILE` | Path to OAuth access/refresh tokens JSON file | OAuth authentication (auto-generated after first authorization) |

**Authentication Notes:**
- Use `YT_API_KEY` for read-only operations on public data
- Use `YT_CLIENT_SECRETS_FILE` + `YT_ACCESS_TOKENS_FILE` for authenticated operations (uploads, modifications, private data)
- OAuth credentials are file-based: the client secrets file contains your app credentials, and the access tokens file stores your authenticated session
- Never commit API keys or credential files to version control
- Add credential files to `.gitignore`
- API keys should be restricted to YouTube Data API only in Google Cloud Console

### Generating OAuth Credentials

For OAuth credential file generation, use the `yt_cli` package:

```bash
# Install yt_cli
dart pub global activate yt_cli

# Run OAuth flow to generate credentials
yt authorize

# This creates two files:
#   - client_secrets.json (download from Google Cloud Console)
#   - access_tokens.json (auto-generated after authorization)
#
# Set the environment variables to point to these files:
export YT_CLIENT_SECRETS_FILE="path/to/client_secrets.json"
export YT_ACCESS_TOKENS_FILE="~/.yt/access_tokens.json"
```

**Note:** The `access_tokens.json` file is automatically created and managed by the `yt` package after successful authorization. It contains your access and refresh tokens and is automatically updated when tokens expire.

### Debug Mode

By default, error details are logged to stderr without stack traces to prevent information leakage.

To enable verbose error logging (for development only):

```bash
# When running from source
dart run -D YT_MCP_DEBUG=true bin/yt_mcp_server.dart

# When compiled
dart compile exe -D YT_MCP_DEBUG=true -o yt_mcp bin/yt_mcp_server.dart
```

**Warning:** Do not enable debug mode in production environments.

## Development Setup

This section is for developers who want to modify the yt_mcp source code or add new tools.

### Prerequisites

- Dart SDK >= 3.8.0
- YouTube Data API key or OAuth credentials

### Running from Source

If you're working on the package locally, you can run the server directly from source instead of using the globally activated version:

```bash
cd packages/yt_mcp
dart pub get
dart run bin/yt_mcp_server.dart
```

### Code Generation

The MCP dispatcher (`lib/src/yt_mcp_server.mcp.dart`) is pre-generated and committed to the repository. You only need to run `build_runner` if you're modifying the `YtMcpServer` class or adding new tools.

If you modify `lib/src/yt_mcp_server.dart`, regenerate the dispatcher:

```bash
dart run build_runner build
```

This produces `lib/src/yt_mcp_server.mcp.dart`, which wires up all tool handlers.

## Testing with MCP Inspector

The [MCP Inspector](https://github.com/modelcontextprotocol/inspector) (`@modelcontextprotocol/inspector`) is the preferred tool for interactively debugging and testing the server.

1. **Install the inspector globally:**

   ```bash
   npm install -g @modelcontextprotocol/inspector
   ```

2. **Launch the inspector connected to the server:**

   ```bash
   cd packages/yt_mcp
   npx @modelcontextprotocol/inspector dart run bin/yt_mcp_server.dart
   ```

   Or if you've activated the package globally:

   ```bash
   npx @modelcontextprotocol/inspector yt_mcp
   ```

   Or if you installed via Homebrew:

   ```bash
   npx @modelcontextprotocol/inspector yt_mcp
   ```

3. **Browse and invoke tools** in the web UI that opens automatically. You can inspect request/response payloads for each tool call.

4. **Provide authentication credentials** by placing a `.env` file in the `packages/yt_mcp/` or `packages/yt_mcp/bin/` directory with your `YT_API_KEY` or OAuth credential file paths.

## Contributing

Contributions are welcome! This package is part of the [yt workspace](https://github.com/cdavis-code/yt_workspace).

**Before submitting a PR:**
1. Make changes to `lib/src/yt_mcp_server.dart` (add `@Tool` annotated methods)
2. Regenerate the dispatcher: `dart run build_runner build`
3. Run analysis: `dart analyze`
4. Format code: `dart format .`

See the [workspace README](../../README.md) for development setup.

### Homebrew Releases

This package supports Homebrew installation via the `cdavis-code/yt` tap. To release a new version:

1. **Update the version** in `packages/yt_mcp/pubspec.yaml`

2. **Push a version tag** matching `yt_mcp-v*`:
   ```bash
   git tag yt_mcp-v2.3.0
   git push origin yt_mcp-v2.3.0
   ```

3. **GitHub Actions workflow** automatically:
   - Compiles native binaries for macOS (ARM64 + x64) and Linux (x64)
   - Creates a GitHub Release with all binaries
   - Updates `homebrew/yt_mcp.rb` with the new version and SHA256
   - Syncs the formula to the `cdavis-code/homebrew-yt` tap repository

4. **Users install/update** via:
   ```bash
   brew upgrade yt-mcp
   ```

**Required secrets:** Set `HOMEBREW_TAP_TOKEN` in the GitHub repo under **Settings > Secrets and variables > Actions** (GitHub PAT with write access to `cdavis-code/homebrew-yt`).

**Note:** The Homebrew release workflow (`.github/workflows/homebrew-release.yml`) supports both `yt_cli` and `yt_mcp` packages. Tags must follow the format `yt_cli-v*` or `yt_mcp-v*` to trigger the automated build and release process.

## License

MIT — see the [LICENSE](../../LICENSE) file for details.
