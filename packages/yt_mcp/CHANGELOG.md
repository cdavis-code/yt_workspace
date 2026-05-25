# Changelog

## [2.3.2] - 2026-05-25

### Changed
- Updated yt dependency to `^3.2.0` (from `^3.0.2`)
- Full API parity with yt package: all 26 YouTube API services exposed as 90+ MCP tools
- Services now covered: Activities, Analytics, Broadcast, Captions, ChannelBanners, ChannelSections, Channels, Chat, CommentThreads, Comments, I18nLanguages, I18nRegions, LiveStream, Members, MembershipsLevels, PlaylistImages, PlaylistItems, Playlists, Search, Subscriptions, ThirdPartyLinks, Thumbnails, VideoAbuseReportReasons, VideoCategories, Videos, Watermarks

### Notes
- Built on yt package version 3.2.0
- Depends on yt ^3.2.0
- Uses dart_mcp ^0.5.1 for MCP protocol implementation
- Requires easy_api_generator ^1.2.2 for code generation

## [2.3.1] - 2026-05-19

### Added
- Hybrid Tool Architecture with `codeModeVisible: true` for core read/query tools
- Enhanced tool descriptions with usage examples for better LLM understanding
- Tool annotations (`readOnlyHint`, `destructiveHint`, `idempotentHint`, `openWorldHint`)
- Direct tool visibility for: `search_list`, `channels_list`, `videos_list`, `subscriptions_list`, `playlist_items_list`, `comment_threads_list`, `videos_insert`, `subscriptions_insert`
- Improved natural language query support (e.g., "what channels do I subscribe to?")

### Changed
- Updated tool descriptions to be more actionable and LLM-friendly
- Removed `managedByMe` and `mine` parameters from `channels_list` (use OAuth `mine=true` via environment)
- Simplified authentication: OAuth credentials checked before API key in priority order
- Changed executable name from `yt_mcp` to `yt-mcp` in pubspec.yaml for consistency with Homebrew formula

### Notes
- Built on yt package version 3.0.2
- Depends on yt ^3.0.2
- Uses dart_mcp ^0.5.1 for MCP protocol implementation
- Requires easy_api_generator ^1.0.2 for code generation

## [2.2.6] - 2025-05-08

### Added
- Initial release as separate package
- MCP server for YouTube Data and Live Streaming APIs
- Integration with AI assistants via Model Context Protocol
- Tool definitions for all supported YouTube API operations

### Notes
- Built on yt package version 2.2.6
- Depends on yt ^2.2.6
- Uses dart_mcp for MCP protocol implementation
