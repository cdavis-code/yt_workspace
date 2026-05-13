# VideoAbuseReportReasons API Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement VideoAbuseReportReasons YouTube Data API with CLI commands and MCP endpoint.

**Architecture:** OAuth-only read-only API following existing yt package patterns. Models use json_serializable, provider uses Retrofit, API class extends YouTubeApiHelper. Added to yt_base as nullable field with getter that throws if unavailable.

**Tech Stack:** Dart SDK ^3.8.0, json_serializable, retrofit_generator, easy_api_annotations (MCP)

---

## File Structure

**Created files:**
- `packages/yt/lib/src/model/video_abuse_report_reasons/*.dart` (4 model files)
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

---

### Task 1: Model - SecondaryReason

**Files:**
- Create: `packages/yt/lib/src/model/video_abuse_report_reasons/secondary_reason.dart`

- [ ] **Step 1: Write SecondaryReason model**

```dart
import 'package:json_annotation/json_annotation.dart';

part 'secondary_reason.g.dart';

@JsonSerializable()
class SecondaryReason {
  final String id;
  final String label;

  SecondaryReason({
    required this.id,
    required this.label,
  });

  factory SecondaryReason.fromJson(Map<String, dynamic> json) =>
      _$SecondaryReasonFromJson(json);

  Map<String, dynamic> toJson() => _$SecondaryReasonToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/video_abuse_report_reasons/secondary_reason.dart
git commit -m "feat: add SecondaryReason model for VideoAbuseReportReasons API"
```

---

### Task 2: Model - VideoAbuseReportReasonSnippet

**Files:**
- Create: `packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason_snippet.dart`

- [ ] **Step 1: Write VideoAbuseReportReasonSnippet model**

```dart
import 'package:json_annotation/json_annotation.dart';

import 'secondary_reason.dart';

part 'video_abuse_report_reason_snippet.g.dart';

@JsonSerializable()
class VideoAbuseReportReasonSnippet {
  final String label;

  @JsonKey(name: 'secondaryReasons')
  final List<SecondaryReason>? secondaryReasons;

  VideoAbuseReportReasonSnippet({
    required this.label,
    this.secondaryReasons,
  });

  factory VideoAbuseReportReasonSnippet.fromJson(Map<String, dynamic> json) =>
      _$VideoAbuseReportReasonSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$VideoAbuseReportReasonSnippetToJson(this);
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason_snippet.dart
git commit -m "feat: add VideoAbuseReportReasonSnippet model for VideoAbuseReportReasons API"
```

---

### Task 3: Model - VideoAbuseReportReason

**Files:**
- Create: `packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason.dart`

- [ ] **Step 1: Write VideoAbuseReportReason model**

```dart
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'video_abuse_report_reason_snippet.dart';

part 'video_abuse_report_reason.g.dart';

@JsonSerializable()
class VideoAbuseReportReason extends ResponseMetadata {
  final String id;
  final VideoAbuseReportReasonSnippet? snippet;

  VideoAbuseReportReason({
    required super.kind,
    required super.etag,
    required this.id,
    this.snippet,
  });

  factory VideoAbuseReportReason.fromJson(Map<String, dynamic> json) =>
      _$VideoAbuseReportReasonFromJson(json);

  Map<String, dynamic> toJson() => _$VideoAbuseReportReasonToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason.dart
git commit -m "feat: add VideoAbuseReportReason model for VideoAbuseReportReasons API"
```

---

### Task 4: Model - VideoAbuseReportReasonListResponse

**Files:**
- Create: `packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason_list_response.dart`

- [ ] **Step 1: Write VideoAbuseReportReasonListResponse model**

```dart
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../response_metadata.dart';
import 'video_abuse_report_reason.dart';

part 'video_abuse_report_reason_list_response.g.dart';

@JsonSerializable()
class VideoAbuseReportReasonListResponse extends ResponseMetadata {
  final List<VideoAbuseReportReason> items;

  VideoAbuseReportReasonListResponse({
    required super.kind,
    required super.etag,
    required this.items,
  });

  factory VideoAbuseReportReasonListResponse.fromJson(
          Map<String, dynamic> json) =>
      _$VideoAbuseReportReasonListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VideoAbuseReportReasonListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/model/video_abuse_report_reasons/video_abuse_report_reason_list_response.dart
git commit -m "feat: add VideoAbuseReportReasonListResponse model for VideoAbuseReportReasons API"
```

---

### Task 5: Provider - VideoAbuseReportReasonsClient

**Files:**
- Create: `packages/yt/lib/src/provider/data/video_abuse_report_reasons.dart`

- [ ] **Step 1: Write VideoAbuseReportReasonsClient Retrofit provider**

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'video_abuse_report_reasons.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class VideoAbuseReportReasonsClient {
  factory VideoAbuseReportReasonsClient(Dio dio, {String baseUrl}) =
      _VideoAbuseReportReasonsClient;

  @GET('/videoAbuseReportReasons')
  Future<VideoAbuseReportReasonListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('hl') String? hl,
  });
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/provider/data/video_abuse_report_reasons.dart
git commit -m "feat: add VideoAbuseReportReasonsClient Retrofit provider"
```

---

### Task 6: API Class - VideoAbuseReportReasons

**Files:**
- Create: `packages/yt/lib/src/video_abuse_report_reasons.dart`

- [ ] **Step 1: Write VideoAbuseReportReasons API class**

```dart
import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/video_abuse_report_reasons.dart';

class VideoAbuseReportReasons extends YouTubeApiHelper {
  final VideoAbuseReportReasonsClient _rest;

  VideoAbuseReportReasons({required super.dio}) : _rest = VideoAbuseReportReasonsClient(dio);

  Future<VideoAbuseReportReasonListResponse> list({
    String part = 'id,snippet',
    String? hl,
  }) async => _rest.list(
    accept,
    buildParts([], part),
    hl: hl,
  );
}
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt/lib/src/video_abuse_report_reasons.dart
git commit -m "feat: add VideoAbuseReportReasons API class"
```

---

### Task 7: Update yt_base.dart - Add Fields

**Files:**
- Modify: `packages/yt/lib/src/yt_base.dart`

- [ ] **Step 1: Add nullable field after _membershipsLevels (around line 33)**

Add:

```dart
  VideoAbuseReportReasons? _videoAbuseReportReasons;
```

- [ ] **Step 2: Add getter after membershipsLevels getter (around line 77)**

Add:

```dart
  VideoAbuseReportReasons get videoAbuseReportReasons =>
      _videoAbuseReportReasons == null
          ? throw Exception(_moduleUnavailableMessage)
          : _videoAbuseReportReasons!;
```

- [ ] **Step 3: Add initialization in setModules under useTokenAuth block (around line 227)**

Add after _membershipsLevels initialization:

```dart
      /// A videoAbuseReportReason resource contains information about a reason
      /// that a video would be flagged for containing abusive content.
      _videoAbuseReportReasons = VideoAbuseReportReasons(dio: dio);
```

- [ ] **Step 4: Commit**

```bash
git add packages/yt/lib/src/yt_base.dart
git commit -m "feat: add VideoAbuseReportReasons to Yt class"
```

---

### Task 8: Update yt.dart - Add Exports

**Files:**
- Modify: `packages/yt/lib/yt.dart`

- [ ] **Step 1: Add import for new API**

Add after existing exports section:

```dart
export 'src/video_abuse_report_reasons.dart';
```

- [ ] **Step 2: Add model exports**

Add after existing model exports:

```dart
export 'src/model/video_abuse_report_reasons/video_abuse_report_reason.dart';
export 'src/model/video_abuse_report_reasons/video_abuse_report_reason_list_response.dart';
export 'src/model/video_abuse_report_reasons/video_abuse_report_reason_snippet.dart';
export 'src/model/video_abuse_report_reasons/secondary_reason.dart';
```

- [ ] **Step 3: Commit**

```bash
git add packages/yt/lib/yt.dart
git commit -m "feat: export VideoAbuseReportReasons models and API"
```

---

### Task 9: Run build_runner for yt package

**Files:**
- None (generates .g.dart files)

- [ ] **Step 1: Run melos build**

```bash
melos run build
```

Expected: Generates all `.g.dart` files for video_abuse_report_reasons models and provider.

- [ ] **Step 2: Verify generated files exist**

```bash
ls packages/yt/lib/src/model/video_abuse_report_reasons/*.g.dart
ls packages/yt/lib/src/provider/data/video_abuse_report_reasons.g.dart
```

Expected: All 5 .g.dart files should exist.

- [ ] **Step 3: Run analyze to check for errors**

```bash
cd packages/yt && dart analyze --fatal-infos
```

Expected: No issues found.

- [ ] **Step 4: Commit generated files**

```bash
git add packages/yt/lib/src/model/video_abuse_report_reasons/*.g.dart
git add packages/yt/lib/src/provider/data/video_abuse_report_reasons.g.dart
git commit -m "feat: add generated .g.dart files for VideoAbuseReportReasons"
```

---

### Task 10: CLI - Update YtHelperCommand

**Files:**
- Modify: `packages/yt_cli/lib/src/cmd/youtube_helper_command.dart`

- [ ] **Step 1: Add getter for videoAbuseReportReasons**

Add after existing getters:

```dart
  VideoAbuseReportReasons get videoAbuseReportReasons =>
      _yt.videoAbuseReportReasons;
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt_cli/lib/src/cmd/youtube_helper_command.dart
git commit -m "feat: add videoAbuseReportReasons getter to YtHelperCommand"
```

---

### Task 11: CLI - YoutubeVideoAbuseReportReasonsCommand

**Files:**
- Create: `packages/yt_cli/lib/src/cmd/youtube_video_abuse_report_reasons_command.dart`

- [ ] **Step 1: Write YoutubeVideoAbuseReportReasonsCommand**

```dart
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:yt/yt.dart';

import 'youtube_helper_command.dart';

class YoutubeVideoAbuseReportReasonsCommand extends Command<void> {
  @override
  String get description =
      'A videoAbuseReportReason resource contains information about a reason that a video would be flagged for containing abusive content.';

  @override
  String get name => 'video-abuse-report-reasons';

  YoutubeVideoAbuseReportReasonsCommand() {
    addSubcommand(YoutubeListVideoAbuseReportReasonsCommand());
  }
}

class YoutubeListVideoAbuseReportReasonsCommand extends YtHelperCommand {
  @override
  String get description =
      'Retrieves a list of reasons that can be used to report abusive videos.';

  @override
  String get name = 'list';

  YoutubeListVideoAbuseReportReasonsCommand() {
    argParser
      ..addOption(
        'part',
        defaultsTo: 'id,snippet',
        help:
            'The part parameter specifies the videoAbuseReportReason resource parts that the API response will include.',
      )
      ..addOption(
        'hl',
        valueHelp: 'language',
        help:
            'The hl parameter specifies the language that should be used for text values in the API response.',
      );
  }

  @override
  void run() async {
    await initializeYt();

    try {
      final response = await videoAbuseReportReasons.list(
        part: argResults!['part'],
        hl: argResults?['hl'],
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
git add packages/yt_cli/lib/src/cmd/youtube_video_abuse_report_reasons_command.dart
git commit -m "feat: add YoutubeVideoAbuseReportReasonsCommand for CLI"
```

---

### Task 12: CLI - Register Commands

**Files:**
- Modify: `packages/yt_cli/bin/yt.dart`
- Modify: `packages/yt_cli/lib/yt_cli.dart`

- [ ] **Step 1: Add import and command registration in yt.dart**

Add import:

```dart
import 'src/cmd/youtube_video_abuse_report_reasons_command.dart';
```

Add command registration after existing commands:

```dart
    ..addCommand(YoutubeVideoAbuseReportReasonsCommand())
```

- [ ] **Step 2: Add export in yt_cli.dart**

Add after existing exports:

```dart
export 'src/cmd/youtube_video_abuse_report_reasons_command.dart';
```

- [ ] **Step 3: Run analyze to verify CLI**

```bash
cd packages/yt_cli && dart analyze --fatal-infos
```

Expected: No issues found.

- [ ] **Step 4: Commit**

```bash
git add packages/yt_cli/bin/yt.dart packages/yt_cli/lib/yt_cli.dart
git commit -m "feat: register VideoAbuseReportReasons command in CLI"
```

---

### Task 13: MCP - Add VideoAbuseReportReasons Tool

**Files:**
- Modify: `packages/yt_mcp/lib/src/yt_mcp_server.dart`

- [ ] **Step 1: Add video_abuse_report_reasons_list tool method**

Add after existing tool methods:

```dart
  // -----------------------------------------------------------------------
  // VideoAbuseReportReasons
  // -----------------------------------------------------------------------

  @Tool(
    name: 'video_abuse_report_reasons_list',
    description: 'Retrieves reasons for reporting abusive videos (requires OAuth).',
  )
  Future<Map<String, dynamic>> videoAbuseReportReasonsList({
    @Parameter(description: 'Comma-separated resource property names')
    String part = 'id,snippet',
    @Parameter(description: 'Language code for localized labels')
    String? hl,
  }) async {
    final response = await _yt.videoAbuseReportReasons.list(
      part: part,
      hl: hl,
    );
    return response.toJson();
  }
```

- [ ] **Step 2: Commit**

```bash
git add packages/yt_mcp/lib/src/yt_mcp_server.dart
git commit -m "feat: add video_abuse_report_reasons_list MCP tool"
```

---

### Task 14: Run build_runner for yt_mcp

**Files:**
- None (generates .mcp.dart file)

- [ ] **Step 1: Run melos build**

```bash
melos run build
```

Expected: Regenerates `yt_mcp_server.mcp.dart` with new tool.

- [ ] **Step 2: Verify generated file**

```bash
grep -A5 'video_abuse_report_reasons_list' packages/yt_mcp/lib/src/yt_mcp_server.mcp.dart
```

Expected: Should find video_abuse_report_reasons_list in generated code.

- [ ] **Step 3: Run analyze on yt_mcp**

```bash
cd packages/yt_mcp && dart analyze --fatal-infos
```

Expected: No issues found.

- [ ] **Step 4: Commit**

```bash
git add packages/yt_mcp/lib/src/yt_mcp_server.mcp.dart
git commit -m "feat: regenerate MCP server with VideoAbuseReportReasons tool"
```

---

### Task 15: Final Verification

**Files:**
- None

- [ ] **Step 1: Run full analyze**

```bash
melos run analyze
```

Expected: SUCCESS for all 5 packages.

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

- [ ] **Step 5: Summary commit (if any formatting changes)**

If formatting changes were made:

```bash
git add packages/yt packages/yt_cli packages/yt_mcp
git commit -m "style: format VideoAbuseReportReasons implementation"
```