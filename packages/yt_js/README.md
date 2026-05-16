# yt_js

JavaScript/TypeScript bindings for the [yt](https://pub.dev/packages/yt) Dart package — YouTube Data, Live Streaming, and Analytics APIs for browser and Node.js.

[![npm](https://img.shields.io/npm/v/@unngh/yt-js)](https://www.npmjs.com/package/@unngh/yt-js)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start

### Installation

```bash
npm install @unngh/yt-js
```

### Usage

```typescript
import { Yt } from '@unngh/yt-js';

// Initialize with API key
const yt = new Yt.withKey('YOUR_API_KEY');

// Use YouTube APIs
const response = await yt.search.list(q: 'Dart programming');
```

### Environment-Specific Imports

| Import path | Environment |
|-------------|-------------|
| `@unngh/yt-js` | Auto-detected (default) |
| `@unngh/yt-js/browser` | Browser only |
| `@unngh/yt-js/node` | Node.js only |

## Features

- YouTube Data API v3 (search, channels, playlists, videos, etc.)
- YouTube Live Streaming API (broadcasts, streams, chat)
- YouTube Analytics API
- Works in both browser and Node.js (ESM and CJS)
- Compiled from Dart for type safety and performance

## Build Process

The build pipeline compiles Dart source to JavaScript in two stages:

1. **dart2js** — compiles `yt` Dart library to JS with O4 optimization
2. **tsup** — bundles the output with TypeScript wrappers into ESM and CJS formats

```bash
# Full build (dart2js + tsup)
npm run build

# Individual stages
npm run build:dart    # dart2js only
npm run build:ts      # tsup only

# Run tests
npm test
```

## Publishing

Releases to npm are handled automatically via GitHub Actions (`dart.yml`).

| Trigger | Behavior |
|---------|----------|
| Push to `main` that changes `packages/yt/lib/**` | Auto-bumps patch version and publishes |
| Push a `yt_js-v*` tag | Builds and publishes the current version |

Manual release via tag:

```bash
git tag yt_js-v2.3.0
git push origin yt_js-v2.3.0
```

## Configuration

Authentication is required via one of:

- **API Key** — for public, read-only access
- **OAuth2 tokens** — for authenticated user operations

## Documentation

- [yt Dart package](https://pub.dev/packages/yt) — core library documentation
- [YouTube Data API](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API](https://developers.google.com/youtube/v3/live/docs)
- [Repository](https://github.com/cdavis-code/yt_workspace/tree/main/packages/yt_js)

## Contributing

Any help from the open-source community is always welcome:

- Found an issue? Please file a bug report with details.
- Need a feature? Open a feature request with use cases.
- Are you a developer? Fix a bug and send a pull request.

## License

MIT License — see [LICENSE](../yt/LICENSE) for details.
