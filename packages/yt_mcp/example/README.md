# yt_mcp Example

This example demonstrates how to configure and use the `yt_mcp` server with MCP-compatible AI assistants.

## Prerequisites

1. **YouTube API Key** (for read-only access)
   - Get one from [Google Cloud Console](https://console.cloud.google.com/apis/credentials)

2. **OR OAuth Credentials** (for full access - uploads, updates, deletes)
   - Download `client_secrets.json` from Google Cloud Console
   - Run `yt authorize` to generate `access_tokens.json`

## Quick Start

### Step 1: Install yt_mcp

```bash
# Option 1: Global Dart activation
dart pub global activate yt_mcp

# Option 2: Homebrew (macOS/Linux)
brew tap cdavis-code/yt
brew install yt-mcp
```

### Step 2: Configure Credentials

Create a `.env` file in your working directory:

```bash
# For read-only access (API key)
YT_API_KEY=your-api-key-here

# OR for full access (OAuth)
YT_CLIENT_SECRETS_FILE=/path/to/client_secrets.json
YT_ACCESS_TOKENS_FILE=/path/to/access_tokens.json
```

### Step 3: Configure Your MCP Host

#### Qoder

Add to your `.qoder/mcp.json`:

```json
{
  "mcpServers": {
    "yt-mcp": {
      "command": "yt-mcp"
    }
  }
}
```

#### Claude Desktop

Add to your Claude Desktop configuration:

```json
{
  "mcpServers": {
    "yt-mcp": {
      "command": "yt-mcp",
      "env": {
        "YT_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

#### VS Code

Add to your `.vscode/mcp.json`:

```json
{
  "servers": {
    "yt-mcp": {
      "command": "yt-mcp"
    }
  }
}
```

### Step 4: Test the Connection

Start your AI assistant and ask natural language questions:

- "Search for Dart programming tutorials on YouTube"
- "What channels do I subscribe to?" (requires OAuth)
- "Show me trending videos"
- "List my playlists" (requires OAuth)

## Advanced Usage

### Code Mode Execution

For complex workflows, use the `yt_execute` tool with JavaScript:

```javascript
// Search and get detailed video information in one call
const [search, videos] = await Promise.all([
  external_yt_search_list({
    q: 'Flutter tutorial',
    type: 'video',
    maxResults: 5
  }),
  external_yt_videos_list({
    chart: 'mostPopular',
    part: 'snippet,statistics',
    maxResults: 5
  })
]);

return {
  searchResults: search.items?.length || 0,
  trendingVideos: videos.items?.length || 0
};
```

### Upload a Video (OAuth Required)

```javascript
const result = await external_yt_videos_insert({
  body: {
    snippet: {
      title: 'My Video',
      description: 'Video description',
      tags: ['tutorial', 'dart'],
      categoryId: '28'
    },
    status: {
      privacyStatus: 'private'
    }
  },
  videoFilePath: '/path/to/video.mp4',
  part: 'snippet,status,contentDetails'
});

return { videoId: result.id };
```

## Available Tools

The server exposes 90+ YouTube API operations across 26 services:

- **Search**: `yt_search_list`
- **Videos**: list, insert, update, delete, rate
- **Channels**: list, update
- **Playlists**: list, insert, update, delete
- **Comments**: full CRUD + moderation
- **Live Streaming**: broadcasts, streams, chat
- **Analytics**: reports, groups
- **And more...**

See the [README.md](../README.md) for the complete tool list.

## Troubleshooting

### API Key Issues

```bash
# Test API key from command line
export YT_API_KEY="your-key"
yt-mcp
```

### OAuth Issues

```bash
# Verify credential files exist
ls -la ~/.yt/

# Re-authorize if tokens expired
yt authorize
```

### Debug Mode

Enable verbose error logging (development only):

```bash
dart run -D YT_MCP_DEBUG=true bin/yt_mcp_server.dart
```

## Additional Resources

- [yt_mcp README](../README.md) - Full documentation
- [yt package](https://pub.dev/packages/yt) - Core YouTube API library
- [YouTube Data API Docs](https://developers.google.com/youtube/v3/docs)
- [MCP Protocol](https://modelcontextprotocol.io/)
