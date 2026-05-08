# yt_cli

A CLI tool for the YouTube Data and Live Streaming APIs.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start

### Installation

```sh
# Using dart pub
dart pub global activate yt_cli

# Using homebrew
brew tap faithoflifedev/yt
brew install yt
```

### Usage

```sh
yt --help
```

## Features

- Authorize and manage YouTube API credentials
- List, insert, update, and delete YouTube resources
- Manage live broadcasts and streams
- Interact with live chat messages
- Access playlists, videos, channels, and search results

## Commands

```
Available commands:
  authorize          Generate a refresh token used to authenticate the command line API requests
  broadcast          A liveBroadcast resource represents an event that will be streamed, via live video, on YouTube.
  channels           A channel resource contains information about a YouTube channel.
  chat               A liveChatMessage resource represents a chat message in a YouTube live chat.
  playlists          A playlist resource represents a YouTube playlist.
  search             A search result contains information about a YouTube video, channel, or playlist.
  stream             A liveStream resource contains information about the video stream that you are transmitting to YouTube.
  subscriptions      A subscription resource contains information about a YouTube user subscription.
  thumbnails         A thumbnail resource identifies different thumbnail image sizes associated with a resource.
  video-categories   A videoCategory resource identifies a category that has been or could be associated with uploaded videos.
  videos             A video resource represents a YouTube video.
```

## Configuration

Before using the CLI, you need to authorize it with your YouTube credentials:

```sh
yt authorize
```

Follow the prompts to provide your client ID, client secret, and complete the OAuth2 authentication flow.

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
