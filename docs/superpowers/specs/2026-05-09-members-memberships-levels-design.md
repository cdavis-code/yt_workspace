# Members and MembershipsLevels API Implementation Design

**Date:** 2026-05-09
**Author:** OpenCode

## Overview

Implement Members and MembershipsLevels APIs for the YouTube Data API in the yt package, with CLI commands and MCP endpoints.

Both APIs:
- OAuth-only (require channel owner authorization)
- Read-only (only `list` method)
- For channel-memberships-enabled channels

## API Reference

- **Members API:** https://developers.google.com/youtube/v3/docs/members
- **MembershipsLevels API:** https://developers.google.com/youtube/v3/docs/membershipsLevels

## Package Structure

### yt package (packages/yt)

```
lib/src/
├── members.dart                   # Members API class
├── memberships_levels.dart        # MembershipsLevels API class
├── model/
│   └── members/
│       ├── member.dart            # Member resource
│       ├── member.g.dart
│       ├── member_list_response.dart
│       ├── member_list_response.g.dart
│       ├── member_details.dart
│       ├── member_details.g.dart
│       ├── memberships_details.dart
│       ├── memberships_details.g.dart
│       ├── memberships_duration.dart
│       ├── memberships_duration.g.dart
│       ├── memberships_duration_at_level.dart
│       └── memberships_duration_at_level.g.dart
│   └── memberships_levels/
│       ├── memberships_level.dart
│       ├── memberships_level.g.dart
│       ├── memberships_level_list_response.dart
│       ├── memberships_level_list_response.g.dart
│       ├── memberships_level_snippet.dart
│       ├── memberships_level_snippet.g.dart
│       ├── level_details.dart
│       └── level_details.g.dart
├── provider/data/
│   ├── members.dart               # Retrofit client
│   ├── members.g.dart
│   ├── memberships_levels.dart    # Retrofit client
│   ├── memberships_levels.g.dart
```

### yt_cli package (packages/yt_cli)

```
lib/src/cmd/
├── youtube_members_command.dart
├── youtube_memberships_levels_command.dart
```

### yt_mcp package (packages/yt_mcp)

Update `lib/src/yt_mcp_server.dart` with new tool methods.

## Model Classes

### Members API Models

1. **Member** - Top-level resource
   - `kind: String` (always "youtube#member")
   - `etag: String`
   - `snippet: MemberSnippet`

2. **MemberSnippet** - Member details container
   - `creatorChannelId: String`
   - `memberDetails: MemberDetails?`
   - `membershipsDetails: MembershipsDetails`

3. **MemberDetails** - Profile data (optional for deleted channels)
   - `channelId: String?`
   - `channelUrl: String?`
   - `displayName: String?`
   - `profileImageUrl: String?`

4. **MembershipsDetails** - Membership info
   - `highestAccessibleLevel: String`
   - `highestAccessibleLevelDisplayName: String`
   - `accessibleLevels: List<String>`
   - `membershipsDuration: MembershipsDuration`
   - `membershipsDurationAtLevel: List<MembershipsDurationAtLevel>`

5. **MembershipsDuration** - Overall duration
   - `memberSince: DateTime`
   - `memberTotalDurationMonths: int`

6. **MembershipsDurationAtLevel** - Per-level duration
   - `level: String`
   - `memberSince: DateTime`
   - `memberTotalDurationMonths: int`

7. **MemberListResponse** - Paginated response
   - `kind: String`
   - `etag: String`
   - `nextPageToken: String?`
   - `pageInfo: PageInfo?`
   - `items: List<Member>`

### MembershipsLevels API Models

1. **MembershipsLevel** - Top-level resource
   - `kind: String` (always "youtube#membershipsLevel")
   - `etag: String`
   - `id: String`
   - `snippet: MembershipsLevelSnippet`

2. **MembershipsLevelSnippet** - Level details container
   - `creatorChannelId: String`
   - `levelDetails: LevelDetails`

3. **LevelDetails** - Level display info
   - `displayName: String`

4. **MembershipsLevelListResponse** - Response wrapper
   - `kind: String`
   - `etag: String`
   - `items: List<MembershipsLevel>`

## API Classes

### Members

```dart
class Members extends YouTubeApiHelper {
  final MembersClient _rest;
  
  Members({required super.dio}) : _rest = MembersClient(dio);
  
  Future<MemberListResponse> list({
    String part = 'snippet',
    String? mode,  // 'allCurrentMembers' or 'updatesSince'
    int? maxResults,
    String? pageToken,
  });
}
```

### MembershipsLevels

```dart
class MembershipsLevels extends YouTubeApiHelper {
  final MembershipsLevelsClient _rest;
  
  MembershipsLevels({required super.dio}) : _rest = MembershipsLevelsClient(dio);
  
  Future<MembershipsLevelListResponse> list({
    String part = 'id,snippet',
  });
}
```

## Provider Clients (Retrofit)

### MembersClient

```dart
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class MembersClient {
  @GET('/members')
  Future<MemberListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('mode') String? mode,
    @Query('maxResults') int? maxResults,
    @Query('pageToken') String? pageToken,
  });
}
```

### MembershipsLevelsClient

```dart
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class MembershipsLevelsClient {
  @GET('/membershipsLevels')
  Future<MembershipsLevelListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part,
  });
}
```

## yt_base.dart Integration

Add to `Yt` class:
- `_members` and `_membershipsLevels` nullable fields
- `members` and `membershipsLevels` getters that throw if unavailable (OAuth-only)
- Initialize in `setModules()` under `useTokenAuth` block

## CLI Commands

### youtube_members_command.dart

```dart
class YoutubeMembersCommand extends Command<void> {
  @override
  String get name => 'members';
  
  YoutubeMembersCommand() {
    addSubcommand(YoutubeListMembersCommand());
  }
}

class YoutubeListMembersCommand extends YtHelperCommand {
  @override
  String get name => 'list';
  
  // Options: --mode, --max-results, --page-token
}
```

### youtube_memberships_levels_command.dart

```dart
class YoutubeMembershipsLevelsCommand extends Command<void> {
  @override
  String get name => 'memberships-levels';
  
  YoutubeMembershipsLevelsCommand() {
    addSubcommand(YoutubeListMembershipsLevelsCommand());
  }
}

class YoutubeListMembershipsLevelsCommand extends YtHelperCommand {
  @override
  String get name => 'list';
}
```

Add getters to `YtHelperCommand`:
- `Members get members => _yt.members;`
- `MembershipsLevels get membershipsLevels => _yt.membershipsLevels;`

## MCP Endpoints

Add to `yt_mcp_server.dart`:

```dart
@Tool(
  name: 'members_list',
  description: 'Lists channel members (requires OAuth).',
)
Future<Map<String, dynamic>> membersList({
  @Parameter(description: 'Comma-separated member property names')
  String part = 'snippet',
  @Parameter(description: 'Mode: allCurrentMembers or updatesSince')
  String? mode,
  @Parameter(description: 'Maximum items to return')
  int? maxResults,
  @Parameter(description: 'Page token for pagination')
  String? pageToken,
}) async {
  final response = await _yt.members.list(
    part: part,
    mode: mode,
    maxResults: maxResults,
    pageToken: pageToken,
  );
  return response.toJson();
}

@Tool(
  name: 'memberships_levels_list',
  description: 'Lists membership levels for the channel (requires OAuth).',
)
Future<Map<String, dynamic>> membershipsLevelsList({
  @Parameter(description: 'Comma-separated level property names')
  String part = 'id,snippet',
}) async {
  final response = await _yt.membershipsLevels.list(part: part);
  return response.toJson();
}
```

## Exports

Add to `lib/yt.dart`:
- `export 'src/members.dart';`
- `export 'src/memberships_levels.dart';`
- `export 'src/model/members/member.dart';`
- `export 'src/model/members/member_list_response.dart';`
- `export 'src/model/members/member_details.dart';`
- `export 'src/model/members/memberships_details.dart';`
- `export 'src/model/memberships_levels/memberships_level.dart';`
- `export 'src/model/memberships_levels/memberships_level_list_response.dart';`

## Build Process

1. Create all model files with `@JsonSerializable()` annotations
2. Create provider REST clients with Retrofit annotations
3. Create API classes (members.dart, memberships_levels.dart)
4. Update yt_base.dart with OAuth-only module pattern
5. Update yt.dart exports
6. Run `melos run build` to generate `.g.dart` files
7. Create CLI commands
8. Update YtHelperCommand with new getters
9. Add MCP tool methods
10. Run `melos run build` again for yt_mcp
11. Run `melos run lint:all` to verify