# VideoAbuseReportReasons API Implementation Design

## Overview

Implement the YouTube Data API `videoAbuseReportReasons` endpoint with full integration across yt package, CLI, and MCP server.

## API Characteristics

- **Endpoint**: `GET https://www.googleapis.com/youtube/v3/videoAbuseReportReasons`
- **Authentication**: OAuth-only (requires authentication token)
- **Methods**: Read-only - only `list` available
- **Pagination**: None (returns all available reasons in single response)
- **Parameters**:
  - `part` (string) - defaults to "id,snippet"
  - `hl` (string, optional) - language code for localized labels

## Package Structure

### Models (4 files)

Location: `packages/yt/lib/src/model/video_abuse_report_reasons/`

1. **secondary_reason.dart**
   - Properties: `id` (String), `label` (String)
   - Simple nested object within snippet

2. **video_abuse_report_reason_snippet.dart**
   - Properties: `label` (String), `secondaryReasons` (List<SecondaryReason>)
   - Contains main reason text and optional secondary reasons

3. **video_abuse_report_reason.dart**
   - Extends: ResponseMetadata (kind, etag)
   - Properties: `id` (String), `snippet` (VideoAbuseReportReasonSnippet?)
   - Main resource representing an abuse report reason

4. **video_abuse_report_reason_list_response.dart**
   - Extends: ResponseMetadata (kind, etag)
   - Properties: `items` (List<VideoAbuseReportReason>)
   - No pageInfo or nextPageToken (single response)

### Provider (1 file)

Location: `packages/yt/lib/src/provider/data/video_abuse_report_reasons.dart`

- Retrofit client with single `list` method
- Parameters: Accept header, part, optional hl
- Returns: VideoAbuseReportReasonListResponse

### API Class (1 file)

Location: `packages/yt/lib/src/video_abuse_report_reasons.dart`

- Extends YouTubeApiHelper
- Single `list` method with part and optional hl parameters
- OAuth-only module (nullable field in yt_base.dart with getter that throws if unavailable)

### yt_base.dart Integration

- Add nullable `_videoAbuseReportReasons` field
- Add getter with exception for unavailable module
- Initialize in `setModules()` under `useTokenAuth` block

### yt.dart Exports

- Export API class: `src/video_abuse_report_reasons.dart`
- Export models: all 4 model files from video_abuse_report_reasons directory

### CLI (1 file)

Location: `packages/yt_cli/lib/src/cmd/youtube_video_abuse_report_reasons_command.dart`

- Command structure: `video-abuse-report-reasons` with `list` subcommand
- Parameters: --part (defaults to "id,snippet"), --hl (optional)
- Added to YtHelperCommand as getter
- Registered in youtube_command.dart

### MCP (1 tool)

Location: `packages/yt_mcp/lib/src/yt_mcp_server.dart`

- Tool name: `video_abuse_report_reasons_list`
- Parameters: part, hl (optional)
- Returns: Map<String, dynamic> via toJson()

## Implementation Tasks

1. Create SecondaryReason model
2. Create VideoAbuseReportReasonSnippet model
3. Create VideoAbuseReportReason model
4. Create VideoAbuseReportReasonListResponse model
5. Create VideoAbuseReportReasonsClient Retrofit provider
6. Create VideoAbuseReportReasons API class
7. Update yt_base.dart (field, getter, initialization)
8. Update yt.dart exports
9. Run build_runner for yt package
10. Update YtHelperCommand getter
11. Create YoutubeVideoAbuseReportReasonsCommand
12. Register CLI command
13. Add MCP tool
14. Run build_runner for yt_mcp
15. Final verification

## File Locations Summary

**Created files:**
- `packages/yt/lib/src/model/video_abuse_report_reasons/secondary_reason.dart`
- `packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason_snippet.dart`
- `packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason.dart`
- `packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason_list_response.dart`
- `packages/yt/lib/src/provider/data/video_abuse_report_reasons.dart`
- `packages/yt/lib/src/video_abuse_report_reasons.dart`
- `packages/yt_cli/lib/src/cmd/youtube_video_abuse_report_reasons_command.dart`

**Modified files:**
- `packages/yt/lib/src/yt_base.dart`
- `packages/yt/lib/yt.dart`
- `packages/yt_cli/lib/src/cmd/youtube_helper_command.dart`
- `packages/yt_cli/lib/src/cmd/youtube_command.dart`
- `packages/yt_cli/lib/yt_cli.dart`
- `packages/yt_mcp/lib/src/yt_mcp_server.dart`