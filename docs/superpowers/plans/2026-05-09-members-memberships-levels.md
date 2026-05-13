# Members and MembershipsLevels API Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement Members and MembershipsLevels YouTube Data APIs with CLI commands and MCP endpoints.

**Architecture:** OAuth-only read-only APIs following existing yt package patterns. Models use json_serializable, providers use Retrofit, API classes extend YouTubeApiHelper. Added to yt_base as nullable fields with getters that throw if unavailable.

**Tech Stack:** Dart SDK ^3.8.0, json_serializable, retrofit_generator, easy_api_annotations (MCP)

---

## File Structure

**Created files:**
- `packages/yt/lib/src/model/members/*.dart` (7 model files)
- `packages/yt/lib/src/model/memberships_levels/*.dart` (4 model files)
- `packages/yt/lib/src/provider/data/members.dart`
- `packages/yt/lib/src/provider/data/memberships_levels.dart`
- `packages/yt/lib/src/members.dart`
- `packages/yt/lib/src/memberships_levels.dart`
- `packages/yt_cli/lib/src/cmd/youtube_members_command.dart`
- `packages/yt_cli/lib/src/cmd/youtube_memberships_levels_command.dart`

**Modified files:**
- `packages/yt/lib/src/yt_base.dart`
- `packages/yt/lib/yt.dart`
- `packages/yt_cli/lib/src/cmd/youtube_helper_command.dart`
- `packages/yt_cli/lib/src/cmd/youtube_command.dart`
- `packages/yt_mcp/lib/src/yt_mcp_server.dart`

---

### Task 1: Members Model - MemberDetails

**Files:**
- Create: `packages/yt/lib/src/model/members/member_details.dart`

- [ ] **Step 1: Write MemberDetails model**

```dart
import 'package:json_annotation/json_annotation.dart';

part 'member_details.g.dart';

@JsonSerializable()
class MemberDetails {
  final String? channelId;
  final String? channelUrl;
  final String? displayName;
  final String? profileImageUrl;

  MemberDetails({
    this.channelId,
    this.channelUrl,
    this.displayName,
    this.profileImageUrl,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDetailsToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/member_details.dart
git commit -m "feat: add MemberDetails model for Members API"
```

---

### Task 2: Members Model - MembershipsDuration

**Files:**
- Create: `packages/yt/lib/src/model/members/memberships_duration.dart`

- [ ] **Step 1: Write MembershipsDuration model**

```dart
import 'package:json_annotation/json_annotation.dart';

part 'memberships_duration.g.dart';

@JsonSerializable()
class MembershipsDuration {
  @JsonKey(name: 'memberSince')
  final DateTime memberSince;

  @JsonKey(name: 'memberTotalDurationMonths')
  final int memberTotalDurationMonths;

  MembershipsDuration({
    required this.memberSince,
    required this.memberTotalDurationMonths,
  });

  factory MembershipsDuration.fromJson(Map<String, dynamic> json) =>
      _$MembershipsDurationFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsDurationToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/memberships_duration.dart
git commit -m "feat: add MembershipsDuration model for Members API"
```

---

### Task 3: Members Model - MembershipsDurationAtLevel

**Files:**
- Create: `packages/yt/lib/src/model/members/memberships_duration_at_level.dart`

- [ ] **Step 1: Write MembershipsDurationAtLevel model**

```dart
import 'package:json_annotation/json_annotation.dart';

part 'memberships_duration_at_level.g.dart';

@JsonSerializable()
class MembershipsDurationAtLevel {
  final String level;

  @JsonKey(name: 'memberSince')
  final DateTime memberSince;

  @JsonKey(name: 'memberTotalDurationMonths')
  final int memberTotalDurationMonths;

  MembershipsDurationAtLevel({
    required this.level,
    required this.memberSince,
    required this.memberTotalDurationMonths,
  });

  factory MembershipsDurationAtLevel.fromJson(Map<String, dynamic> json) =>
      _$MembershipsDurationAtLevelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsDurationAtLevelToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/memberships_duration_at_level.dart
git commit -m "feat: add MembershipsDurationAtLevel model for Members API"
```

---

### Task 4: Members Model - MembershipsDetails

**Files:**
- Create: `packages/yt/lib/src/model/members/memberships_details.dart`

- [ ] **Step 1: Write MembershipsDetails model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'memberships_duration.dart';
import 'memberships_duration_at_level.dart';

part 'memberships_details.g.dart';

@JsonSerializable()
class MembershipsDetails {
  @JsonKey(name: 'highestAccessibleLevel')
  final String highestAccessibleLevel;

  @JsonKey(name: 'highestAccessibleLevelDisplayName')
  final String highestAccessibleLevelDisplayName;

  @JsonKey(name: 'accessibleLevels')
  final List<String> accessibleLevels;

  @JsonKey(name: 'membershipsDuration')
  final MembershipsDuration membershipsDuration;

  @JsonKey(name: 'membershipsDurationAtLevel')
  final List<MembershipsDurationAtLevel> membershipsDurationAtLevel;

  MembershipsDetails({
    required this.highestAccessibleLevel,
    required this.highestAccessibleLevelDisplayName,
    required this.accessibleLevels,
    required this.membershipsDuration,
    required this.membershipsDurationAtLevel,
  });

  factory MembershipsDetails.fromJson(Map<String, dynamic> json) =>
      _$MembershipsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsDetailsToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/memberships_details.dart
git commit -m "feat: add MembershipsDetails model for Members API"
```

---

### Task 5: Members Model - MemberSnippet

**Files:**
- Create: `packages/yt/lib/src/model/members/member_snippet.dart`

- [ ] **Step 1: Write MemberSnippet model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'member_details.dart';
import 'memberships_details.dart';

part 'member_snippet.g.dart';

@JsonSerializable()
class MemberSnippet {
  @JsonKey(name: 'creatorChannelId')
  final String creatorChannelId;

  @JsonKey(name: 'memberDetails')
  final MemberDetails? memberDetails;

  @JsonKey(name: 'membershipsDetails')
  final MembershipsDetails membershipsDetails;

  MemberSnippet({
    required this.creatorChannelId,
    this.memberDetails,
    required this.membershipsDetails,
  });

  factory MemberSnippet.fromJson(Map<String, dynamic> json) =>
      _$MemberSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$MemberSnippetToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/member_snippet.dart
git commit -m "feat: add MemberSnippet model for Members API"
```

---

### Task 6: Members Model - Member

**Files:**
- Create: `packages/yt/lib/src/model/members/member.dart`

- [ ] **Step 1: Write Member model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'member_snippet.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  final String kind;
  final String etag;
  final MemberSnippet snippet;

  Member({
    this.kind = 'youtube#member',
    required this.etag,
    required this.snippet,
  });

  factory Member.fromJson(Map<String, dynamic> json) =>
      _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/member.dart
git commit -m "feat: add Member model for Members API"
```

---

### Task 7: Members Model - MemberListResponse

**Files:**
- Create: `packages/yt/lib/src/model/members/member_list_response.dart`

- [ ] **Step 1: Write MemberListResponse model**

```dart
import 'package:json_annotation/json_annotation.dart';

import '../page_info.dart';
import 'member.dart';

part 'member_list_response.g.dart';

@JsonSerializable()
class MemberListResponse {
  final String kind;
  final String etag;

  @JsonKey(name: 'nextPageToken')
  final String? nextPageToken;

  @JsonKey(name: 'pageInfo')
  final PageInfo? pageInfo;

  final List<Member> items;

  MemberListResponse({
    this.kind = 'youtube#memberListResponse',
    required this.etag,
    this.nextPageToken,
    this.pageInfo,
    required this.items,
  });

  factory MemberListResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberListResponseToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/members/member_list_response.dart
git commit -m "feat: add MemberListResponse model for Members API"
```

---

### Task 8: MembershipsLevels Model - LevelDetails

**Files:**
- Create: `packages/yt/lib/src/model/memberships_levels/level_details.dart`

- [ ] **Step 1: Write LevelDetails model**

```dart
import 'package:json_annotation/json_annotation.dart';

part 'level_details.g.dart';

@JsonSerializable()
class LevelDetails {
  @JsonKey(name: 'displayName')
  final String displayName;

  LevelDetails({
    required this.displayName,
  });

  factory LevelDetails.fromJson(Map<String, dynamic> json) =>
      _$LevelDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDetailsToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/memberships_levels/level_details.dart
git commit -m "feat: add LevelDetails model for MembershipsLevels API"
```

---

### Task 9: MembershipsLevels Model - MembershipsLevelSnippet

**Files:**
- Create: `packages/yt/lib/src/model/memberships_levels/memberships_level_snippet.dart`

- [ ] **Step 1: Write MembershipsLevelSnippet model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'level_details.dart';

part 'memberships_level_snippet.g.dart';

@JsonSerializable()
class MembershipsLevelSnippet {
  @JsonKey(name: 'creatorChannelId')
  final String creatorChannelId;

  @JsonKey(name: 'levelDetails')
  final LevelDetails levelDetails;

  MembershipsLevelSnippet({
    required this.creatorChannelId,
    required this.levelDetails,
  });

  factory MembershipsLevelSnippet.fromJson(Map<String, dynamic> json) =>
      _$MembershipsLevelSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsLevelSnippetToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/memberships_levels/memberships_level_snippet.dart
git commit -m "feat: add MembershipsLevelSnippet model for MembershipsLevels API"
```

---

### Task 10: MembershipsLevels Model - MembershipsLevel

**Files:**
- Create: `packages/yt/lib/src/model/memberships_levels/memberships_level.dart`

- [ ] **Step 1: Write MembershipsLevel model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'memberships_level_snippet.dart';

part 'memberships_level.g.dart';

@JsonSerializable()
class MembershipsLevel {
  final String kind;
  final String etag;
  final String id;
  final MembershipsLevelSnippet snippet;

  MembershipsLevel({
    this.kind = 'youtube#membershipsLevel',
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory MembershipsLevel.fromJson(Map<String, dynamic> json) =>
      _$MembershipsLevelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsLevelToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/memberships_levels/memberships_level.dart
git commit -m "feat: add MembershipsLevel model for MembershipsLevels API"
```

---

### Task 11: MembershipsLevels Model - MembershipsLevelListResponse

**Files:**
- Create: `packages/yt/lib/src/model/memberships_levels/memberships_level_list_response.dart`

- [ ] **Step 1: Write MembershipsLevelListResponse model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'memberships_level.dart';

part 'memberships_level_list_response.g.dart';

@JsonSerializable()
class MembershipsLevelListResponse {
  final String kind;
  final String etag;
  final List<MembershipsLevel> items;

  MembershipsLevelListResponse({
    this.kind = 'youtube#membershipsLevelListResponse',
    required this.etag,
    required this.items,
  });

  factory MembershipsLevelListResponse.fromJson(Map<String, dynamic> json) =>
      _$MembershipsLevelListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipsLevelListResponseToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/memberships_levels/memberships_level_list_response.dart
git commit -m "feat: add MembershipsLevelListResponse model for MembershipsLevels API"
```

---

### Task 12: Provider - MembersClient

**Files:**
- Create: `packages/yt/lib/src/provider/data/members.dart`

- [ ] **Step 1: Write MembersClient Retrofit provider**

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'members.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class MembersClient {
  factory MembersClient(Dio dio, {String baseUrl}) = _MembersClient;

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

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/provider/data/members.dart
git commit -m "feat: add MembersClient Retrofit provider"
```

---

### Task 13: Provider - MembershipsLevelsClient

**Files:**
- Create: `packages/yt/lib/src/provider/data/memberships_levels.dart`

- [ ] **Step 1: Write MembershipsLevelsClient Retrofit provider**

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'memberships_levels.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class MembershipsLevelsClient {
  factory MembershipsLevelsClient(Dio dio, {String baseUrl}) =
      _MembershipsLevelsClient;

  @GET('/membershipsLevels')
  Future<MembershipsLevelListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part,
  );
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/provider/data/memberships_levels.dart
git commit -m "feat: add MembershipsLevelsClient Retrofit provider"
```

---

### Task 14: API Class - Members

**Files:**
- Create: `packages/yt/lib/src/members.dart`

- [ ] **Step 1: Write Members API class**

```dart
import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/members.dart';

class Members extends YouTubeApiHelper {
  final MembersClient _rest;

  Members({required super.dio}) : _rest = MembersClient(dio);

  Future<MemberListResponse> list({
    String part = 'snippet',
    String? mode,
    int? maxResults,
    String? pageToken,
  }) async => _rest.list(
    accept,
    buildParts([], part),
    mode: mode,
    maxResults: maxResults,
    pageToken: pageToken,
  );
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/members.dart
git commit -m "feat: add Members API class"
```

---

### Task 15: API Class - MembershipsLevels

**Files:**
- Create: `packages/yt/lib/src/memberships_levels.dart`

- [ ] **Step 1: Write MembershipsLevels API class**

```dart
import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/memberships_levels.dart';

class MembershipsLevels extends YouTubeApiHelper {
  final MembershipsLevelsClient _rest;

  MembershipsLevels({required super.dio}) : _rest = MembershipsLevelsClient(dio);

  Future<MembershipsLevelListResponse> list({
    String part = 'id,snippet',
  }) async => _rest.list(
    accept,
    buildParts([], part),
  );
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/memberships_levels.dart
git commit -m "feat: add MembershipsLevels API class"
```

---

### Task 16: Update yt_base.dart - Add Fields

**Files:**
- Modify: `packages/yt/lib/src/yt_base.dart`

- [ ] **Step 1: Add nullable fields after existing fields (around line 32)**

Add after `_chat`:

```dart
  Members? _members;
  MembershipsLevels? _membershipsLevels;
```

- [ ] **Step 2: Add getters after existing getters (around line 75)**

Add after `Chat get chat`:

```dart
  Members get members => _members == null
      ? throw Exception(_moduleUnavailableMessage)
      : _members!;

  MembershipsLevels get membershipsLevels => _membershipsLevels == null
      ? throw Exception(_moduleUnavailableMessage)
      : _membershipsLevels!;
```

- [ ] **Step 3: Add initialization in setModules under useTokenAuth block (around line 224)**

Add after `_chat = Chat(dio: dio);`:

```dart
      /// A member resource represents a YouTube channel member who provides recurring
      /// monetary support to a creator and receives special benefits.
      _members = Members(dio: dio);

      /// A membershipsLevel resource identifies a pricing level managed by the creator.
      _membershipsLevels = MembershipsLevels(dio: dio);
```

- [ ] **Step 4: Commit**

```bash
git add packages/yt/lib/src/yt_base.dart
git commit -m "feat: add Members and MembershipsLevels to Yt class"
```

---

### Task 17: Update yt.dart - Add Exports

**Files:**
- Modify: `packages/yt/lib/yt.dart`

- [ ] **Step 1: Add imports for new APIs**

Add after existing exports section:

```dart
export 'src/members.dart';
export 'src/memberships_levels.dart';
```

- [ ] **Step 2: Add model exports**

Add after existing model exports:

```dart
export 'src/model/members/member.dart';
export 'src/model/members/member_list_response.dart';
export 'src/model/members/member_details.dart';
export 'src/model/members/member_snippet.dart';
export 'src/model/members/memberships_details.dart';
export 'src/model/members/memberships_duration.dart';
export 'src/model/members/memberships_duration_at_level.dart';
export 'src/model/memberships_levels/memberships_level.dart';
export 'src/model/memberships_levels/memberships_level_list_response.dart';
export 'src/model/memberships_levels/memberships_level_snippet.dart';
export 'src/model/memberships_levels/level_details.dart';
```

- [ ] **Step 3: Commit**

```bash
git add packages/yt/lib/yt.dart
git commit -m "feat: export Members and MembershipsLevels models and APIs"
```

---

### Task 18: Run build_runner for yt package

**Files:**
- None (generates .g.dart files)

- [ ] **Step 1: Run melos build**

```bash
melos run build
```

Expected: Generates all `.g.dart` files for members and memberships_levels models and providers.

- [ ] **Step 2: Verify generated files exist**

```bash
ls packages/yt/lib/src/model/members/*.g.dart
ls packages/yt/lib/src/model/memberships_levels/*.g.dart
ls packages/yt/lib/src/provider/data/members.g.dart
ls packages/yt/lib/src/provider/data/memberships_levels.g.dart
```

Expected: All 16 .g.dart files should exist.

- [ ] **Step 3: Run analyze to check for errors**

```bash
cd packages/yt && dart analyze --fatal-infos
```

Expected: No issues found.

- [ ] **Step 4: Commit generated files**

```bash
git add packages/yt/lib/src/model/members/*.g.dart
git add packages/yt/lib/src/model/memberships_levels/*.g.dart
git add packages/yt/lib/src/provider/data/members.g.dart
git add packages/yt/lib/src/provider/data/memberships_levels.g.dart
git commit -m "feat: add generated .g.dart files for Members and MembershipsLevels"
```

---

### Task 19: CLI - Update YtHelperCommand

**Files:**
- Modify: `packages/yt_cli/lib/src/cmd/youtube_helper_command.dart`

- [ ] **Step 1: Add getters for members and membershipsLevels**

Add after existing getters:

```dart
  Members get members => _yt.members;

  MembershipsLevels get membershipsLevels => _yt.membershipsLevels;
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt_cli/lib/src/cmd/youtube_helper_command.dart
git commit -m "feat: add members and membershipsLevels getters to YtHelperCommand"
```

---

### Task 20: CLI - YoutubeMembersCommand

**Files:**
- Create: `packages/yt_cli/lib/src/cmd/youtube_members_command.dart`

- [ ] **Step 1: Write YoutubeMembersCommand**

```dart
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

class YoutubeMembersCommand extends Command<void> {
  @override
  String get description =
      'A member resource represents a YouTube channel member who provides recurring monetary support to a creator and receives special benefits.';

  @override
  String get name => 'members';

  YoutubeMemberCommand() {
    addSubcommand(YoutubeListMembersCommand());
  }
}

class YoutubeListMembersCommand extends YtHelperCommand {
  @override
  String get description => 'Lists members for a channel.';

  @override
  String get name => 'list';

  YoutubeListMembersCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'snippet',
        help:
            'The part parameter specifies the member resource parts that the API response will include.',
      )
      ..addOption(
        'mode',
        defaultsTo: 'allCurrentMembers',
        valueHelp: 'mode',
        help:
            'The mode parameter indicates which members to return. Valid values: allCurrentMembers, updatesSince.',
      )
      ..addOption(
        'max-results',
        defaultsTo: '1000',
        valueHelp: 'number',
        help:
            'The maxResults parameter specifies the maximum number of items to return.',
      )
      ..addOption(
        'page-token',
        valueHelp: 'token',
        help: 'The pageToken parameter identifies a specific page of results.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await members.list(
        part: argResults!['part'],
        mode: argResults?['mode'],
        maxResults: int.tryParse(argResults?['max-results'] ?? ''),
        pageToken: argResults?['page-token'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt_cli/lib/src/cmd/youtube_members_command.dart
git commit -m "feat: add YoutubeMembersCommand for CLI"
```

---

### Task 21: CLI - YoutubeMembershipsLevelsCommand

**Files:**
- Create: `packages/yt_cli/lib/src/cmd/youtube_memberships_levels_command.dart`

- [ ] **Step 1: Write YoutubeMembershipsLevelsCommand**

```dart
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

class YoutubeMembershipsLevelsCommand extends Command<void> {
  @override
  String get description =
      'A membershipsLevel resource identifies a pricing level managed by the creator that authorized the API request.';

  @override
  String get name => 'memberships-levels';

  YoutubeMembershipsLevelsCommand() {
    addSubcommand(YoutubeListMembershipsLevelsCommand());
  }
}

class YoutubeListMembershipsLevelsCommand extends YtHelperCommand {
  @override
  String get description = 'Lists membership levels for the channel.';

  @override
  String get name => 'list';

  YoutubeListMembershipsLevelsCommand() {
    argParser.addOption(
      'part',
      defaultsTo: 'id,snippet',
      help:
          'The part parameter specifies the membershipsLevel resource parts that the API response will include.',
    );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await membershipsLevels.list(
        part: argResults!['part'],
      );

      print(response);

      close();
    } on DioException catch (err) {
      throw UsageException('API usage error:', err.usage);
    }
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt_cli/lib/src/cmd/youtube_memberships_levels_command.dart
git commit -m "feat: add YoutubeMembershipsLevelsCommand for CLI"
```

---

### Task 22: CLI - Register Commands

**Files:**
- Modify: `packages/yt_cli/lib/src/cmd/youtube_command.dart`

- [ ] **Step 1: Find existing command registration file**

Check existing pattern by reading the youtube_command.dart or main entry point to see where commands are registered.

- [ ] **Step 2: Add imports and command registrations**

Add imports:
```dart
import 'youtube_members_command.dart';
import 'youtube_memberships_levels_command.dart';
```

Add command registrations:
```dart
addSubcommand(YoutubeMembersCommand());
addSubcommand(YoutubeMembershipsLevelsCommand());
```

- [ ] **Step 3: Run analyze to verify CLI**

```bash
cd packages/yt_cli && dart analyze --fatal-infos
```

Expected: No issues found.

- [ ] **Step 4: Commit**

```bash
git add packages/yt_cli/lib/src/cmd/youtube_command.dart
git commit -m "feat: register Members and MembershipsLevels commands in CLI"
```

---

### Task 23: MCP - Add Members Tool

**Files:**
- Modify: `packages/yt_mcp/lib/src/yt_mcp_server.dart`

- [ ] **Step 1: Add members_list tool method**

Add after existing tool methods (around line 224):

```dart
  // -----------------------------------------------------------------------
  // Members
  // -----------------------------------------------------------------------

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
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt_mcp/lib/src/yt_mcp_server.dart
git commit -m "feat: add members_list MCP tool"
```

---

### Task 24: MCP - Add MembershipsLevels Tool

**Files:**
- Modify: `packages/yt_mcp/lib/src/yt_mcp_server.dart`

- [ ] **Step 1: Add memberships_levels_list tool method**

Add after members_list tool:

```dart
  // -----------------------------------------------------------------------
  // MembershipsLevels
  // -----------------------------------------------------------------------

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

- [ ] **Step 2: Commit**

```bash
git add packages/yt_mcp/lib/src/yt_mcp_server.dart
git commit -m "feat: add memberships_levels_list MCP tool"
```

---

### Task 25: Run build_runner for yt_mcp

**Files:**
- None (generates .mcp.dart file)

- [ ] **Step 1: Run melos build**

```bash
melos run build
```

Expected: Regenerates `yt_mcp_server.mcp.dart` with new tools.

- [ ] **Step 2: Verify generated file**

```bash
grep -A5 'members_list' packages/yt_mcp/lib/src/yt_mcp_server.mcp.dart
```

Expected: Should find members_list and memberships_levels_list in generated code.

- [ ] **Step 3: Run analyze on yt_mcp**

```bash
cd packages/yt_mcp && dart analyze --fatal-infos
```

Expected: No issues found.

- [ ] **Step 4: Commit**

```bash
git add packages/yt_mcp/lib/src/yt_mcp_server.mcp.dart
git commit -m "feat: regenerate MCP server with Members and MembershipsLevels tools"
```

---

### Task 26: Final Verification

**Files:**
- None

- [ ] **Step 1: Run full lint check**

```bash
melos run lint:all
```

Expected: All packages pass with no issues.

- [ ] **Step 2: Format all files**

```bash
cd packages/yt && dart format .
cd packages/yt_cli && dart format .
cd packages/yt_mcp && dart format .
```

Expected: All files formatted.

- [ ] **Step 3: Final analyze**

```bash
melos run analyze
```

Expected: SUCCESS for all 5 packages.

- [ ] **Step 4: Check git status**

```bash
git status --short
```

Expected: All changes committed.

- [ ] **Step 5: Summary commit**

```bash
git log --oneline -10
```

Expected: Should show all implementation commits.