# yt_js

JavaScript/TypeScript bindings for the yt Dart package, compiled via dart2js. Distributed as an npm package for browser and Node.js consumption.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start

### Installation

```bash
npm install yt_js
```

### Usage

```typescript
import { Yt } from 'yt_js';

// Initialize with API key
const yt = new Yt.withKey('YOUR_API_KEY');

// Use YouTube APIs
const response = await yt.search.list(q: 'Dart programming');
```

## Features

- Native JavaScript/TypeScript API for YouTube Data API
- YouTube Live Streaming API support
- Compiled from Dart for type safety and performance
- Works in both browser and Node.js environments

## Build Process

This package is compiled from Dart using dart2js and distributed as an npm package.

### Development

```bash
# Build the JavaScript bundle
npm run build

# Run tests
npm test
```

## Configuration

The package requires authentication through either:
- API Key (for public read-only access)
- OAuth2 tokens (for authenticated user operations)

## Documentation

- [Main Package Documentation](https://pub.dev/packages/yt)
- [YouTube Data API Reference](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API Reference](https://developers.google.com/youtube/v3/live/docs)

## Contributing

Any help from the open-source community is always welcome:
- Found an issue? Please fill a bug report with details.
- Need a feature? Open a feature request with use cases.
- Are you a developer? Fix a bug and send a pull request.

## License

MIT License - see [LICENSE](../yt/LICENSE) for details.
