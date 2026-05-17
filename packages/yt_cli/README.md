# yt_cli

A CLI tool for the YouTube Data, Live Streaming, and Analytics APIs.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start

### Installation

```sh
# Using dart pub
dart pub global activate yt_cli

# Using homebrew
brew tap cdavis-code/yt
brew install --head yt       # latest development version (builds from source)
# or once a stable release is tagged:
brew install yt
```

Or download a pre-built binary from the [releases page](https://github.com/cdavis-code/yt_workspace/releases).

## Publishing for Homebrew

The `homebrew/` directory at the workspace root contains the canonical formula. To publish a new release:

1. Bump the version in `pubspec.yaml` and regenerate `lib/meta.dart`
2. Publish to pub.dev: `dart pub publish`
3. Push a version tag to trigger the binary build:
   ```sh
   git tag yt_cli-v2.2.7
   git push origin yt_cli-v2.2.7
   ```
4. Wait for the [homebrew-release workflow](../../.github/workflows/homebrew-release.yml) to finish creating the GitHub Release
5. Run the Homebrew release script:
   ```sh
   dart run melos run homebrew
   ```

This downloads the source tarball, computes its SHA256, updates `homebrew/yt.rb`, and syncs the formula to the tap repo.

See `homebrew/README.md` for full tap setup and release documentation.

### Usage

```sh
# Display all available commands
yt --help

# Search for videos
yt search list --q "flutter tutorial" --max-results 5

# List playlists for a channel
yt playlists list --channel-id UC_x5XG1OV2P6uZZ5FSM9Ttw --max-results 10

# View all subcommands for a command
yt videos --help
```

## Features

- OAuth 2.0 web flow authorization with automatic token refresh
- Query channel activity events (uploads, likes, subscriptions, etc.)
- Query YouTube Analytics reports (views, watch time, demographics, and more)
- Manage analytics groups and group items for organizing channels, videos, or playlists
- Full CRUD for channels, playlists, videos, comments, and subscriptions
- Live broadcast and stream management with live chat interaction
- Channel members and membership levels
- Thumbnail and watermark management
- Video abuse report reasons lookup
- Cross-platform: runs on macOS, Linux, and Windows

## Commands

Run `yt --help` for the full list. Key commands:

| Command | Description |
|---------|-------------|
| `activities` | List channel activity events |
| `analytics` | YouTube Analytics reports, groups, and group items |
| `authorize` | OAuth 2.0 web flow to authorize the CLI |
| `broadcast` | Manage live broadcasts |
| `channels` | Retrieve channel information |
| `chat` | Interact with live chat messages |
| `comments` | Manage YouTube comments |
| `comment-threads` | Manage comment threads |
| `members` | List channel members |
| `memberships-levels` | List membership pricing levels |
| `playlists` | Manage playlists |
| `search` | Search for videos, channels, and playlists |
| `stream` | Manage live streams |
| `subscriptions` | Manage channel subscriptions |
| `thumbnails` | Set thumbnail images |
| `version` | Display package name and version |
| `videos` | Manage videos (upload, update, delete) |
| `video-categories` | List video categories |
| `video-abuse-report-reasons` | List abuse report reasons |
| `watermarks` | Manage channel watermarks |

## Configuration

### Authorization

Before using most commands, authorize the CLI with your YouTube account:

```sh
# 1. Download client_secret.json from Google Cloud Console
#    See: https://github.com/cdavis-code/yt_workspace/blob/main/packages/yt_cli/authentication.md

# 2. Run the authorization command
yt authorize

# Or specify a custom path to your credentials file
yt authorize --credentials-file ~/secrets/client_secret.json
```

The CLI starts a local HTTP server, opens an OAuth 2.0 page in your browser,
and saves a permanent refresh token to `youtube_server_tokens.json`. Subsequent
commands automatically refresh the access token in the background.

See [authentication.md](https://github.com/cdavis-code/yt_workspace/blob/main/packages/yt_cli/authentication.md)
for step-by-step setup instructions.

## Documentation

- [Main Package Documentation](https://pub.dev/packages/yt)
- [Authentication Guide](https://github.com/cdavis-code/yt_workspace/blob/main/packages/yt_cli/authentication.md)
- [YouTube Data API Reference](https://developers.google.com/youtube/v3/docs)
- [YouTube Live Streaming API Reference](https://developers.google.com/youtube/v3/live/docs)
- [YouTube Analytics API Reference](https://developers.google.com/youtube/analytics/reference)

## Contributing

Any help from the open-source community is always welcome:
- Found an issue? Please fill a bug report with details.
- Need a feature? Open a feature request with use cases.
- Are you a developer? Fix a bug and send a pull request.

## License

MIT License - see [LICENSE](LICENSE) for details.
