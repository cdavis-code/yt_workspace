# yt_mcp_js

YouTube MCP server compiled to JavaScript for Node.js execution via npx.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start

### Installation

```bash
npx yt_mcp_js
```

Or install globally:

```bash
npm install -g yt_mcp_js
```

### Usage

The MCP server can be used with AI assistants and tools that support the Model Context Protocol to interact with YouTube APIs from Node.js.

## Features

- YouTube MCP server compiled to JavaScript
- Runs in Node.js environments
- No Dart SDK required for end users
- Easy integration via npx
- Full YouTube Data API support
- YouTube Live Streaming API support

## Integration

This server can be integrated with AI tools that support MCP:

```json
{
  "mcpServers": {
    "youtube": {
      "command": "npx",
      "args": ["yt_mcp_js"]
    }
  }
}
```

## Build Process

This package is compiled from Dart using dart2js and distributed as an npm package.

### Development

```bash
# Build the JavaScript bundle
npm run build

# Test the MCP server
npm start
```

## Configuration

The MCP server requires YouTube API credentials to be configured. Use the yt_cli or yt package to set up OAuth2 credentials before running the server.

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
