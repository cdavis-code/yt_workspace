# yt_mcp

![yt_mcp banner](https://raw.githubusercontent.com/cdavis-code/yt_workspace/refs/heads/main/packages/yt_mcp/images/banner.svg)

<p align="center">
  <strong>MCP Server for YouTube APIs</strong><br/>
  AI-Ready YouTube Tools • Built with Dart • Hybrid Tool Architecture • 26 API Services
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
- [Usage Examples](#usage-examples)
  - [Basic Video Search](#example-1-basic-video-search)
  - [Search Different Content Types](#example-2-search-different-content-types)
  - [Filter by View Count](#example-3-filter-by-view-count)
  - [Search with Date Filtering](#example-4-search-with-date-filtering)
  - [Channel Discovery](#example-5-channel-discovery)
  - [Playlist Discovery](#example-6-playlist-discovery)
  - [Compare Search Results](#example-7-compare-search-results)
  - [Search with Region Filtering](#example-8-search-with-region-filtering)
  - [OAuth - My Subscriptions](#example-9-oauth---my-subscriptions)
- [Code Mode Usage](#code-mode-usage)
- [Configuration](#configuration)
- [Development Setup](#development-setup)
- [Testing with MCP Inspector](#testing-with-mcp-inspector)
- [License](#license)

## What's New

### Hybrid Tool Architecture (v2.3.2+)

This release introduces **Hybrid Tool Architecture** for optimal AI assistant interaction:

- **Complete API coverage** — All 90+ tools across 26 YouTube API services fully exposed as MCP tools
- **Core tools directly callable** — Key read/query tools (`search_list`, `channels_list`, `videos_list`, `subscriptions_list`, etc.) are exposed with `codeModeVisible: true` for natural language requests like "what channels do I subscribe to?"
- **Code mode for complex workflows** — All tools accessible via `yt_execute` for JavaScript orchestration with parallel execution
- **Enhanced tool descriptions** — Rich, actionable descriptions with usage examples for better LLM understanding
- **Tool annotations** — `readOnlyHint`, `destructiveHint`, `idempotentHint`, and `openWorldHint` for precise LLM guidance

**How it works:**
1. **Natural language queries**: LLM directly calls visible tools (e.g., `yt_subscriptions_list`)
2. **Complex workflows**: LLM writes JavaScript code using `external_yt_<tool_name>()` functions
3. **Hybrid approach**: Mix direct tool calls with code execution in the same session

**Example - Direct tool call:**
```
User: "What channels do I subscribe to?"
LLM calls: yt_subscriptions_list(mine: true, maxResults: 10)
```

**Example - Code mode execution:**
```javascript
// Search for channels and get their recent videos in one execution
const channels = await external_yt_channels_list({ part: 'snippet', forUsername: 'example' });
const items = channels.items || [];
if (items.length === 0) throw new Error('Channel not found');
const channelId = items[0].id;
const videos = await external_yt_videos_list({ part: 'snippet', channelId: channelId, maxResults: 5 });
return { channels, videos };
```

### Code Mode Foundation (v2.3.0)

Introduced the code mode architecture that v2.3.1 builds upon:

- **Progressive tool discovery** — LLMs search for needed tools by name/description before execution
- **JavaScript code orchestration** — LLMs write JavaScript code to call multiple YouTube API tools in a single execution
- **Parallel execution support** — Use `Promise.all()` to run multiple API calls concurrently
- **Complex logic enabled** — Math operations, data transformations, and conditional logic within a single tool call

### Previous Features (v2.2.x)

- **90+ MCP tools** across all 26 YouTube API services (full parity achieved in v2.3.2)
- **Complete CRUD operations**: Create, update, and delete videos, playlists, comments, subscriptions
- **Live Streaming**: Full broadcast/stream lifecycle management, live chat, cuepoints
- **Analytics**: Reports, groups, and group items management
- **Media Uploads**: Video upload, caption management, thumbnail/watermark uploads
- **Content Management**: Video ratings, abuse reporting, moderation controls

## Quick Start

**For end-users:** Choose between global Dart activation (Option 1) or Homebrew installation (Option 2). Both make the `yt-mcp` command available on your PATH for use with AI agents like Qoder, Claude Desktop, or VS Code.

**For developers:** If you need to modify the source code or add new tools, see the [Development Setup](#development-setup) section below.

### Option 1: Global Dart Activation

```bash
# Activate the package globally (makes the 'yt-mcp' command available)
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

# Install yt_mcp (use hyphenated name: yt-mcp)
brew install yt-mcp

# Verify installation (binary is installed as 'yt-mcp' on your PATH)
which yt-mcp
# Output: /opt/homebrew/bin/yt-mcp (Apple Silicon) or /usr/local/bin/yt-mcp (Intel)

# Configure credentials
export YT_API_KEY="your-api-key-here"
# OR for OAuth:
export YT_CLIENT_SECRETS_FILE="path/to/client_secrets.json"
export YT_ACCESS_TOKENS_FILE="path/to/access_tokens.json"
```

**Note:** Install and run with `yt-mcp` (hyphen), which matches the Homebrew formula name.

That's it! Configure your AI agent using one of the [MCP Host Configuration](#mcp-host-configuration) examples below, and the agent will launch the server automatically.

## Available Tools

### Directly Callable Tools (Hybrid Architecture)

These core tools are visible in both standard tool listing and code mode for natural language interactions:

| Tool | Description | Auth |
|---|---|---|
| **`yt_search_list`** | Search YouTube for videos, channels, and playlists | API Key or OAuth |
| **`yt_channels_list`** | List channels by ID, username, or mine=true | API Key or OAuth |
| **`yt_videos_list`** | List videos by ID or get trending videos | API Key or OAuth |
| **`yt_subscriptions_list`** | List your YouTube subscriptions (mine=true) | OAuth required |
| **`yt_playlist_items_list`** | List items in a playlist | API Key or OAuth |
| **`yt_comment_threads_list`** | List comment threads for a video | API Key or OAuth |
| **`yt_videos_insert`** | Upload a video to YouTube | OAuth required |
| **`yt_subscriptions_insert`** | Subscribe to a channel | OAuth required |

### All API Operations (via yt_execute)

All 90+ YouTube API operations are accessible through the `execute` tool as `external_yt_<tool_name>()` async JavaScript functions:

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

## Usage Examples

This section provides practical examples for common YouTube API workflows using yt_mcp in code mode.

### Example 1: Basic Video Search

**Use case:** Search for videos and display basic information.

```javascript
// Search for videos about "Dart programming"
const result = await external_yt_search_list({
  q: 'Dart programming',
  type: 'video',
  maxResults: 5
});

// Extract video information
const videos = result.items || [];

return {
  count: videos.length,
  videos: videos.map(video => ({
    id: video.id?.videoId || 'N/A',
    title: video.snippet?.title || 'N/A',
    channel: video.snippet?.channelTitle || 'N/A',
    publishedAt: video.snippet?.publishedAt || 'N/A'
  }))
};
```

### Example 2: Search Different Content Types

**Use case:** Search for videos, channels, and playlists in parallel.

```javascript
// Search for different types of content simultaneously
const [videos, channels, playlists] = await Promise.all([
  external_yt_search_list({ q: 'JavaScript tutorial', type: 'video', maxResults: 3 }),
  external_yt_search_list({ q: 'Google', type: 'channel', maxResults: 3 }),
  external_yt_search_list({ q: 'music', type: 'playlist', maxResults: 3 })
]);

return {
  videoCount: videos.items?.length || 0,
  channelCount: channels.items?.length || 0,
  playlistCount: playlists.items?.length || 0,
  sampleVideo: videos.items?.[0]?.snippet?.title || 'N/A',
  sampleChannel: channels.items?.[0]?.snippet?.title || 'N/A',
  samplePlaylist: playlists.items?.[0]?.snippet?.title || 'N/A'
};
```

### Example 3: Filter by View Count

**Use case:** Find the most popular videos on a topic.

```javascript
// Search for popular programming videos
const result = await external_yt_search_list({
  q: 'programming',
  type: 'video',
  order: 'viewCount',
  maxResults: 5
});

const videos = result.items || [];

return {
  query: 'programming (sorted by view count)',
  topVideos: videos.map(v => ({
    title: v.snippet?.title || 'N/A',
    channel: v.snippet?.channelTitle || 'N/A',
    publishedAt: v.snippet?.publishedAt?.split('T')[0] || 'N/A'
  }))
};
```

### Example 4: Search with Date Filtering

**Use case:** Find recently uploaded videos on a topic.

```javascript
// Search for videos uploaded this month
const result = await external_yt_search_list({
  q: 'Dart programming',
  type: 'video',
  order: 'date',
  maxResults: 5
});

const videos = result.items || [];

return {
  query: 'Dart programming (most recent)',
  recentVideos: videos.map(v => ({
    title: v.snippet?.title || 'N/A',
    channel: v.snippet?.channelTitle || 'N/A',
    uploadedAt: v.snippet?.publishedAt?.split('T')[0] || 'N/A'
  }))
};
```

### Example 5: Channel Discovery

**Use case:** Find channels related to a topic.

```javascript
// Search for programming channels
const result = await external_yt_search_list({
  q: 'programming tutorials',
  type: 'channel',
  maxResults: 5
});

const channels = result.items || [];

return {
  channelCount: channels.length,
  channels: channels.map(ch => ({
    title: ch.snippet?.title || 'N/A',
    description: ch.snippet?.description?.substring(0, 100) || 'N/A',
    publishedAt: ch.snippet?.publishedAt?.split('T')[0] || 'N/A'
  }))
};
```

### Example 6: Playlist Discovery

**Use case:** Find playlists for learning a topic.

```javascript
// Search for learning playlists
const result = await external_yt_search_list({
  q: 'learn programming',
  type: 'playlist',
  maxResults: 5
});

const playlists = result.items || [];

return {
  playlistCount: playlists.length,
  playlists: playlists.map(pl => ({
    title: pl.snippet?.title || 'N/A',
    channel: pl.snippet?.channelTitle || 'N/A',
    videoCount: pl.snippet?.channelId ? 'available' : 'N/A'
  }))
};
```

### Example 7: Compare Search Results

**Use case:** Compare different search queries to find the best results.

```javascript
// Test different search queries
const queries = ['Dart programming', 'Flutter development', 'Mobile app development'];

const results = await Promise.all(
  queries.map(q => 
    external_yt_search_list({ q, type: 'video', maxResults: 1 })
  )
);

return {
  comparison: queries.map((q, i) => ({
    query: q,
    resultCount: results[i].items?.length || 0,
    topResult: results[i].items?.[0]?.snippet?.title || 'N/A'
  }))
};
```

### Example 8: Search with Region Filtering

**Use case:** Find content specific to a region.

```javascript
// Search for trending content in a specific region
const result = await external_yt_search_list({
  q: 'cooking',
  type: 'video',
  relevanceLanguage: 'en',
  maxResults: 5
});

const videos = result.items || [];

return {
  query: 'cooking (English relevance)',
  videos: videos.map(v => ({
    title: v.snippet?.title || 'N/A',
    channel: v.snippet?.channelTitle || 'N/A',
    thumbnail: v.snippet?.thumbnails?.default?.url || 'N/A'
  }))
};
```

### Example 9: OAuth - My Subscriptions

**Use case:** Access your personal YouTube subscriptions (requires OAuth authentication).

```javascript
// Get your subscriptions (requires YT_CLIENT_SECRETS_FILE and YT_ACCESS_TOKENS_FILE)
const subscriptions = await external_yt_subscriptions_list({
  part: 'snippet',
  mine: true,
  maxResults: 10
});

const subs = subscriptions.items || [];

return {
  totalSubscriptions: subs.length,
  subscriptions: subs.map(sub => ({
    channelName: sub.snippet?.title || 'N/A',
    channelId: sub.snippet?.resourceId?.channelId || 'N/A',
    description: sub.snippet?.description?.substring(0, 100) || 'N/A',
    thumbnail: sub.snippet?.thumbnails?.default?.url || 'N/A'
  }))
};
```

**Note:** This example requires OAuth credentials. See [Authentication](#authentication) for setup instructions.

## Code Mode Usage

### Basic Example

```javascript
// Search for videos about "Dart programming"
const result = await external_yt_search_list({
  q: 'Dart programming',
  type: 'video',
  maxResults: 5
});

// Safely access items with null checks
const items = result.items || [];
return items.map(item => ({
  id: item.id?.videoId || 'unknown',
  title: item.snippet?.title || 'unknown'
}));
```

### Parallel Execution

```javascript
// Fetch multiple resources in parallel
const [channels, videos, playlists] = await Promise.all([
  external_yt_channels_list({ part: 'snippet', forUsername: 'GoogleDevelopers' }),
  external_yt_videos_list({ part: 'snippet', chart: 'mostPopular', maxResults: 5 }),
  external_yt_playlists_list({ part: 'snippet', channelId: 'UCN9HPn2fq-NL8M5_kp4RWZQ' })
]);

// Safely access array lengths
return { 
  channels: channels.items?.length || 0, 
  videos: videos.items?.length || 0, 
  playlists: playlists.items?.length || 0 
};
```

### Multi-Step Workflow

```javascript
// Find a channel, then get their playlists
const channels = await external_yt_channels_list({ 
  part: 'snippet', 
  forUsername: 'example' 
});

// Safely check if channel was found
if (!channels.items || channels.items.length === 0) {
  throw new Error('Channel not found');
}

const channelId = channels.items[0].id;
const playlists = await external_yt_playlists_list({
  part: 'snippet,contentDetails',
  channelId: channelId,
  maxResults: 10
});

// Safely map playlists with null checks
const items = playlists.items || [];
return items.map(p => ({
  id: p.id,
  title: p.snippet?.title || 'unknown',
  videoCount: p.contentDetails?.itemCount || 0
}));
```

### Using call_tool (Dynamic Invocation)

```javascript
// Alternative: use call_tool for dynamic tool invocation
const result = await call_tool('yt_videos_list', {
  part: 'snippet',
  id: 'dQw4w9WgXcQ'
});

const items = result.items || [];
return items[0]?.snippet?.title || 'Unknown';
```

## Configuration

### Dependencies

```yaml
dependencies:
  yt: ^3.2.0
  easy_api_annotations: ^1.2.2
  dart_mcp: ^0.5.1
```

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
dart compile exe -D YT_MCP_DEBUG=true -o yt-mcp bin/yt_mcp_server.dart
```

**Warning:** Do not enable debug mode in production environments.

### Rate Limiting & API Quotas

**Important:** The YouTube Data API has strict quota limits. Each API call consumes quota units:

| Operation | Quota Cost |
|-----------|-----------|
| `search.list` | 100 units |
| `videos.list` | 1 unit |
| `channels.list` | 1 unit |
| `subscriptions.list` | 1 unit |
| `videos.insert` (upload) | 1600 units |

**Default quota:** 10,000 units per day

**Recommendations:**
- Implement rate limiting at the MCP host level (e.g., Qoder, Claude Desktop)
- Use `maxResults` parameter to minimize API calls
- Cache results when possible
- Monitor your quota in [Google Cloud Console](https://console.cloud.google.com/apis/api/youtube.googleapis.com/quotas)

**Example rate limiting configuration** (for MCP hosts that support it):
```json
{
  "mcpServers": {
    "yt-mcp": {
      "command": "yt-mcp",
      "rateLimit": {
        "requestsPerMinute": 30,
        "requestsPerDay": 100
      }
    }
  }
}
```

**Note:** The yt_mcp server itself does not enforce rate limiting. Protect your API quota by configuring limits in your MCP host or API gateway.

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

### Prerequisites

- **Node.js** installed (required for code mode execution sandbox)
- **YouTube API credentials** (API key or OAuth)

### Step-by-Step Testing

1. **Install the MCP Inspector globally:**

   ```bash
   npm install -g @modelcontextprotocol/inspector
   ```

2. **Launch the Inspector connected to yt-mcp:**

   From source:
   ```bash
   cd packages/yt_mcp
   npx @modelcontextprotocol/inspector dart run bin/yt_mcp_server.dart
   ```

   Or with globally activated package:
   ```bash
   npx @modelcontextprotocol/inspector yt-mcp
   ```

3. **Provide authentication credentials:**

   **Important:** MCP Inspector launches the server as a subprocess and does NOT inherit shell environment variables. You must provide credentials via a `.env` file:

   Create a `.env` file in the `packages/yt_mcp/` directory:
   
   ```bash
   # For read-only access
   YT_API_KEY=your-api-key-here
   
   # OR for full OAuth access
   YT_CLIENT_SECRETS_FILE=/path/to/client_secrets.json
   YT_ACCESS_TOKENS_FILE=/path/to/access_tokens.json
   ```

4. **Test the search tool:**

   In the Inspector UI, call `yt_search` with:
   ```json
   {
     "query": "video search",
     "detail_level": "brief"
   }
   ```
   
   This returns all video-related tools with their names and descriptions.

5. **Test basic execute tool (API key - read-only):**

   Call `yt_execute` with JavaScript code:
   
   ```javascript
   // Simple video search with error handling
   const result = await external_yt_search_list({
     q: 'Dart programming tutorial',
     type: 'video',
     maxResults: 3
   });
   
   // Safely access items (API may return undefined on error)
   const items = result.items || [];
   
   return {
     count: items.length,
     videos: items.map(v => ({
       id: v.id?.videoId || 'unknown',
       title: v.snippet?.title || 'unknown'
     }))
   };
   ```

6. **Test OAuth operations (requires OAuth credentials):**

   If you configured OAuth credentials in step 3, test authenticated operations:
   
   ```javascript
   // Get your subscriptions (requires OAuth)
   const subscriptions = await external_yt_subscriptions_list({
     part: 'snippet',
     mine: true,
     maxResults: 5
   });
   
   const subs = subscriptions.items || [];
   
   return {
     subscriptionCount: subs.length,
     channels: subs.map(s => s.snippet?.title || 'N/A')
   };
   ```
   
   **Expected result:** If OAuth is configured correctly, you'll see your actual subscription count and channel names. If OAuth is not configured, the call will fail with an error.

7. **Test parallel execution:**

   ```javascript
   // Fetch multiple resources concurrently
   const [videos, channels] = await Promise.all([
     external_yt_search_list({ 
       q: 'JavaScript', 
       type: 'video', 
       maxResults: 3 
     }),
     external_yt_search_list({ 
       q: 'Google', 
       type: 'channel', 
       maxResults: 3 
     })
   ]);
   
   return {
     videoCount: videos.items?.length || 0,
     channelCount: channels.items?.length || 0
   };
   ```

8. **Inspect results:**

   Browse the request/response payloads in the web UI to verify:
   - Tool discovery returns expected results
   - JavaScript execution completes successfully
   - API responses are properly formatted
   - Error handling works as expected

### Troubleshooting OAuth in MCP Inspector

If OAuth operations fail:

1. **Check `.env` file location**: Ensure the `.env` file is in the same directory where you run the `npx @modelcontextprotocol/inspector` command
2. **Verify file paths**: Make sure `YT_CLIENT_SECRETS_FILE` and `YT_ACCESS_TOKENS_FILE` point to actual files that exist
3. **Check token expiration**: OAuth access tokens expire after 1 hour (but should auto-refresh using the refresh token)
4. **Validate scopes**: Ensure your OAuth app has the `youtube.force-ssl` scope in Google Cloud Console
5. **Test from command line**: Verify OAuth works outside MCP Inspector:
   ```bash
   cd packages/yt_mcp
   export YT_CLIENT_SECRETS_FILE=/path/to/client_secrets.json
   export YT_ACCESS_TOKENS_FILE=/path/to/access_tokens.json
   dart run bin/yt_mcp_server.dart
   ```

### Debugging Tips

- **View stderr output**: The Inspector shows "Error output from MCP server" pane for debugging
- **Enable verbose errors**: Run with `dart run -D YT_MCP_DEBUG=true bin/yt_mcp_server.dart`
- **Check Node.js**: Ensure `node --version` works (code mode requires Node.js)
- **Timeout issues**: Code execution has a 30-second timeout by default
- **Tool discovery**: Use `detail_level: 'full'` to see complete parameter schemas

## Contributing

Contributions are welcome! This package is part of the [yt workspace](https://github.com/cdavis-code/yt_workspace).

**Before submitting a PR:**
1. Make changes to `lib/src/yt_mcp_server.dart` (add `@Tool` annotated methods)
2. Regenerate the dispatcher: `dart run build_runner build`
3. Run analysis: `dart analyze`
4. Format code: `dart format .`

**Hybrid Architecture Notes:**
- Tools with `codeModeVisible: true` are directly callable by LLMs for natural language queries
- All `@Tool` methods are automatically available in code mode as `external_yt_<tool_name>()` functions
- To exclude a tool from code mode (e.g., destructive operations), add `codeMode: false` to the `@Tool` annotation
- Tools remain visible in standard `tools/list` unless you also set `codeModeVisible: false`
- Tool annotations (`readOnlyHint`, `destructiveHint`, etc.) help LLMs understand tool behavior
- Test new tools using both direct invocation and code mode execution

See the [workspace README](../../README.md) for development setup.

### Homebrew Releases

This package supports Homebrew installation via the `cdavis-code/yt` tap. To release a new version:

1. **Update the version** in `packages/yt_mcp/pubspec.yaml`

2. **Push a version tag** matching `yt_mcp-v*`:
   ```bash
   git tag yt_mcp-v2.3.1
   git push origin yt_mcp-v2.3.1
   ```

3. **GitHub Actions workflow** automatically:
   - Compiles native binaries for macOS (ARM64 + x64) and Linux (x64)
   - Creates a GitHub Release with all binaries
   - Updates `homebrew/yt_mcp.rb` with the new version and SHA256
   - Syncs the formula to the `cdavis-code/homebrew-yt` tap repository

4. **Users install/update** via:
   ```bash
   brew install yt-mcp   # First-time installation
   brew upgrade yt-mcp   # Update to latest version
   ```

**Required secrets:** Set `HOMEBREW_TAP_TOKEN` in the GitHub repo under **Settings > Secrets and variables > Actions** (GitHub PAT with write access to `cdavis-code/homebrew-yt`).

**Note:** The Homebrew release workflow (`.github/workflows/homebrew-release.yml`) supports both `yt_cli` and `yt_mcp` packages. Tags must follow the format `yt_cli-v*` or `yt_mcp-v*` to trigger the automated build and release process.

## License

MIT — see the [LICENSE](../../LICENSE) file for details.
