# yt Workspace

Native Dart interface to multiple YouTube REST APIs including the Data and Live Streaming API.

[![pub package](https://img.shields.io/pub/v/yt.svg)](https://pub.dartlang.org/packages/yt)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Packages

This workspace contains multiple related packages:

| Package | Description | Version |
|---------|-------------|---------|
| [yt](packages/yt/) | Core Dart library for YouTube Data and Live Streaming APIs | [![pub package](https://img.shields.io/pub/v/yt.svg)](https://pub.dartlang.org/packages/yt) |
| [yt_cli](packages/yt_cli/) | CLI tool for YouTube APIs | 2.2.6 |
| [yt_js](packages/yt_js/) | JavaScript/TypeScript bindings for web and Node.js | 2.2.6 |
| [yt_mcp](packages/yt_mcp/) | MCP server for AI assistant integration | 2.2.6 |
| [yt_mcp_js](packages/yt_mcp_js/) | MCP server compiled to JavaScript for Node.js | 2.2.6 |

## Quick Start

### Core Library (Dart/Flutter)

```yaml
dependencies:
  yt: ^2.2.6+1
```

```dart
import 'package:yt/yt.dart';

final yt = Yt.withOAuth();
final playlists = await yt.playlists.list(channelId: 'YOUR_CHANNEL_ID');
```

### CLI Tool

```sh
dart pub global activate yt_cli
yt --help
```

### JavaScript/TypeScript

```bash
npm install yt_js
```

### MCP Server (AI Integration)

```sh
dart pub global activate yt_mcp
```

## Features

- **YouTube Data API**: Channels, Videos, Playlists, Search, Comments, Thumbnails
- **YouTube Live Streaming API**: Live Broadcasts, Streams, Live Chat
- **Multi-platform**: Works with Dart CLI, Flutter (mobile, web, desktop)
- **CLI Tool**: Command-line interface for all supported APIs
- **JavaScript Bindings**: Use YouTube APIs from web and Node.js
- **MCP Server**: AI assistant integration via Model Context Protocol

## Documentation

- [Core Package Documentation](packages/yt/README.md)
- [CLI Documentation](packages/yt_cli/README.md)
- [JavaScript Bindings](packages/yt_js/README.md)
- [MCP Server](packages/yt_mcp/README.md)
- [YouTube Data API Reference](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API Reference](https://developers.google.com/youtube/v3/live/docs)

## Development

### Setup

```sh
# Get dependencies for all packages
melos bootstrap

# Or manually
dart pub get
```

### Build

```sh
# Run build_runner for code generation
melos run build

# Analyze all packages
melos run analyze

# Format all packages
melos run format
```

### Testing

```sh
melos run test
```

## Contributing

Any help from the open-source community is always welcome and needed:
- Found an issue? Please fill a bug report with details.
- Need a feature? Open a feature request with use cases.
- Are you a developer? Fix a bug and send a pull request.
- Are you using and liking the project? Promote it or make a donation.

## License

MIT License - see [LICENSE](packages/yt/LICENSE) for details.

---

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-1.svg)](https://www.buymeacoffee.com/faithoflif2)
