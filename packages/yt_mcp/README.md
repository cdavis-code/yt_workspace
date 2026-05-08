# yt_mcp

MCP (Model Context Protocol) server for YouTube Data and Live Streaming APIs.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start

### Installation

```sh
# Using dart pub
dart pub global activate yt_mcp
```

### Usage

The MCP server can be used with AI assistants and tools that support the Model Context Protocol to interact with YouTube APIs.

```sh
yt_mcp --help
```

## Features

- MCP server implementation for YouTube APIs
- Support for YouTube Data API operations
- Support for YouTube Live Streaming API
- AI-assisted YouTube content management
- Standardized tool interface for LLM integration

## Tools Available

The MCP server provides tools for:
- Searching YouTube videos and channels
- Managing playlists and playlist items
- Retrieving video details and metadata
- Managing live broadcasts and streams
- Interacting with live chat messages
- Managing thumbnails and video uploads

## Configuration

### OAuth2 Setup

Before using the MCP server, configure your YouTube API credentials:

```sh
# Use the yt_cli authorize command
yt authorize
```

## Integration

This server can be integrated with AI tools that support MCP:

```json
{
  "mcpServers": {
    "youtube": {
      "command": "yt_mcp",
      "args": []
    }
  }
}
```

## Documentation

- [Main Package Documentation](https://pub.dev/packages/yt)
- [YouTube Data API Reference](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API Reference](https://developers.google.com/youtube/v3/live/docs)
- [Model Context Protocol](https://modelcontextprotocol.io/)

## Contributing

Any help from the open-source community is always welcome:
- Found an issue? Please fill a bug report with details.
- Need a feature? Open a feature request with use cases.
- Are you a developer? Fix a bug and send a pull request.

## License

MIT License - see [LICENSE](../yt/LICENSE) for details.
