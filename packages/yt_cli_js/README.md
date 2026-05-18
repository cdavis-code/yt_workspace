# @unngh/youtube-cli

<p align="center">
<img src="https://raw.githubusercontent.com/cdavis-code/yt_workspace/refs/heads/main/packages/yt_cli_js/images/banner.svg" alt="@unngh/youtube-cli - YouTube CLI for Node.js" width="100%">
</p>

YouTube Data API CLI tool for Node.js — search, channels, videos, playlists, activities, live streaming, comments, analytics, and more. Compiled from the [yt](https://pub.dev/packages/yt) Dart package via dart2js.

[![npm](https://img.shields.io/npm/v/@unngh/youtube-cli)](https://www.npmjs.com/package/@unngh/youtube-cli)
[![Node.js](https://img.shields.io/badge/node-%3E%3D18-3C873A)](https://nodejs.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🔍 **Full YouTube Data API coverage** — search, channels, videos, playlists, activities, comments, subscriptions, members
- 📡 **Live Streaming API** — manage broadcasts, streams, transitions, and bindings
- 📊 **YouTube Analytics API** — query metrics, manage analytics groups and group items
- 🔑 **Auth flexibility** — API key (read-only) or OAuth 2.0 (read/write)
- 📦 **Single binary install** — runs anywhere Node.js ≥ 18 runs (macOS, Linux, Windows)
- 🧱 **JSON-first output** — every command emits JSON to stdout, perfect for `jq` pipelines

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Commands](#commands)
- [Global Options](#global-options)
- [Examples](#examples)
- [Build Process](#build-process)
- [License](#license)

## Requirements

- **Node.js ≥ 18** (the CLI ships as ESM and uses native `fetch`)
- A **YouTube Data API key** or **OAuth 2.0 client credentials** from [Google Cloud Console](https://console.cloud.google.com/apis/credentials)

## Installation

```bash
# Install globally
npm install -g @unngh/youtube-cli

# Or run directly with npx
npx @unngh/youtube-cli
```

## Configuration

YouTube API access requires either an API key (read-only) or OAuth 2.0 credentials.

| Action Type | Authentication Requirement | Why |
|---|---|---|
| Reading Public Data | API Key or OAuth 2.0 | Accesses data anyone can see (e.g., public video titles, search results). |
| Reading Private Data | OAuth 2.0 Required | Accesses data specific to a user (e.g., a user's private videos or watch history). |
| Writing/Modifying Data | OAuth 2.0 Required | Performs actions on behalf of a user (e.g., uploading, deleting, or commenting). |

### API Key

Provide your YouTube Data API key using either:

- **Flag:** `--api-key YOUR_API_KEY`
- **Environment variable:** `export YT_API_KEY=YOUR_API_KEY`

To obtain an API key, visit the [Google Cloud Console](https://console.cloud.google.com/apis/credentials) and create a new API key with YouTube Data API v3 enabled.

## Commands

| Command | Subcommands | Description |
|---------|-------------|-------------|
| `search` | list | Search for videos, channels, and playlists |
| `channels` | list | Get channel information |
| `videos` | list | Get video details |
| `playlists` | list | Get playlist information |
| `activities` | list | Get channel activity feeds |
| `broadcast` | list, insert, update, delete, transition, bind | Manage live broadcasts |
| `stream` | list, insert, update, delete | Manage live streams |
| `comments` | list, list-by-ids, list-by-id, insert, update, delete, set-moderation-status | Manage comments |
| `comment-threads` | list, list-by-id, insert | Manage comment threads |
| `subscriptions` | list, insert, delete | Manage subscriptions |
| `thumbnails` | set | Upload video thumbnails |
| `watermarks` | set, unset | Manage channel watermarks |
| `members` | list | List channel members |
| `memberships-levels` | list | List membership levels |
| `video-categories` | list | List video categories |
| `video-abuse-report-reasons` | list | List abuse report reasons |
| `analytics` | query, groups-list, groups-insert, groups-update, groups-delete, group-items-list, group-items-insert, group-items-delete | YouTube Analytics |
| `authorize` | — | OAuth authorization info |
| `version` | — | Display version |

## Global Options

| Option | Description |
|--------|-------------|
| `--api-key <key>` | YouTube Data API key (overrides `YT_API_KEY` env var) |
| `--log-level <level>` | Log level: `all`, `debug`, `info`, `warning`, `error` (default: `off`) |
| `--help` | Show help for a command |
| `--version` | Show version number |

## Examples

### Search

```bash
# Search for videos
youtube-cli search list --q "TypeScript tutorial" --max-results 5

# Search for channels only
youtube-cli search list --q "Google" --type channel
```

### Channels

```bash
# Get channel by ID
youtube-cli channels list --id UC_x5XG1OV2P6uZZ5FSM9Ttw --part snippet,statistics

# Get channel by username
youtube-cli channels list --for-username GoogleDevelopers
```

### Videos

```bash
# Get video details
youtube-cli videos list --id dQw4w9WgXcQ --part snippet,statistics,contentDetails

# Get multiple videos
youtube-cli videos list --id "dQw4w9WgXcQ,jNQXAC9IVRw"
```

### Playlists

```bash
# Get playlists for a channel
youtube-cli playlists list --channel-id UC_x5XG1OV2P6uZZ5FSM9Ttw --part snippet

# Get playlist by ID
youtube-cli playlists list --id PLRqwX-V7Uu6ZiZxtDDRCi6uhfTH4FilpH
```

### Activities

```bash
# Get recent activity for a channel
youtube-cli activities list --channel-id UC_x5XG1OV2P6uZZ5FSM9Ttw --max-results 10
```

### Broadcast

```bash
# List upcoming broadcasts
youtube-cli broadcast list --broadcast-status upcoming

# Create a new broadcast
youtube-cli broadcast insert --body '{"snippet":{"title":"My Live Stream","scheduledStartTime":"2026-06-01T20:00:00Z"},"status":{"privacyStatus":"public"}}'

# Transition a broadcast to live
youtube-cli broadcast transition --id BROADCAST_ID --broadcast-status live

# Bind a broadcast to a stream
youtube-cli broadcast bind --id BROADCAST_ID --stream-id STREAM_ID
```

### Comments

```bash
# List replies to a comment
youtube-cli comments list --parent-id COMMENT_ID

# Get a single comment by ID
youtube-cli comments list-by-id --id COMMENT_ID

# Insert a new comment
youtube-cli comments insert --body '{"snippet":{"parentId":"COMMENT_ID","textOriginal":"Great video!"}}'

# Set moderation status
youtube-cli comments set-moderation-status --id COMMENT_ID --moderation-status published
```

### Subscriptions

```bash
# List subscriptions for a channel
youtube-cli subscriptions list --channel-id UC_x5XG1OV2P6uZZ5FSM9Ttw

# List your own subscriptions (requires OAuth)
youtube-cli subscriptions list --mine

# Subscribe to a channel
youtube-cli subscriptions insert --body '{"snippet":{"resourceId":{"kind":"youtube#channel","channelId":"UC_x5XG1OV2P6uZZ5FSM9Ttw"}}}'

# Unsubscribe
youtube-cli subscriptions delete --id SUBSCRIPTION_ID
```

### Analytics

```bash
# Query channel analytics for a date range
youtube-cli analytics query --ids "channel==MINE" --start-date 2026-01-01 --end-date 2026-01-31 --metrics views,likes,comments

# Query with dimensions and filters
youtube-cli analytics query --ids "channel==MINE" --start-date 2026-01-01 --end-date 2026-01-31 --metrics views --dimensions day --sort -views

# List analytics groups
youtube-cli analytics groups-list --mine

# Create an analytics group
youtube-cli analytics groups-insert --body '{"snippet":{"title":"Top Videos"}}'
```

### Output

All commands output JSON to stdout, making it easy to pipe into other tools:

```bash
youtube-cli search list --q "Dart" | jq '.items[].snippet.title'
```

## Build Process

The CLI is compiled from the [yt_cli](https://github.com/cdavis-code/yt_workspace/tree/main/packages/yt_cli) Dart package using `dart2js`, then wrapped with a TypeScript/Commander.js interface via `tsup`.

```bash
# Build from the yt_cli_js package directory
npm run build
```

## Related

- [yt](https://pub.dev/packages/yt) — Core Dart package for YouTube APIs
- [yt_cli](https://github.com/cdavis-code/yt_workspace/tree/main/packages/yt_cli) — Native Dart CLI (installable via Homebrew)
- [@unngh/youtube-api](https://www.npmjs.com/package/@unngh/youtube-api) — JavaScript/TypeScript library bindings
- [CHANGELOG](./CHANGELOG.md) — Release history
- [GitHub Repository](https://github.com/cdavis-code/yt_workspace)

## License

MIT License — see [LICENSE](./LICENSE) for details.
