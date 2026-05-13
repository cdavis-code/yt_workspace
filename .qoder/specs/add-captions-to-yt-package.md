# Add YouTube Captions API to yt Package

## Context
The `yt` package currently covers YouTube Data API and Live Streaming API, but lacks support for the [YouTube Captions API](https://developers.google.com/youtube/v3/docs/captions). This plan adds caption management (list, insert, update, delete, download) following the established patterns in the codebase.

## Implementation Steps

### Step 1: Create Models (3 files)

**`packages/yt/lib/src/model/captions/snippet.dart`**
- `CaptionTrackKind` enum: `standard`, `ASR`
- `CaptionAudioTrackType` enum: `main`, `descriptive`, `commentary`, `unknown`
- `CaptionStatus` enum: `serving`, `failed`, `syncing`
- `CaptionSnippet` class with `@JsonSerializable(explicitToJson: true)`:
  - `videoId` (String, required)
  - `lastUpdated` (DateTime, read-only)
  - `trackKind` (CaptionTrackKind)
  - `language` (String, BCP-47 code like "en")
  - `name` (String?, display name)
  - `audioTrackType` (CaptionAudioTrackType?)
  - `isCC`, `isLarge`, `isEasyReader`, `isDraft`, `isAutoSynced` (bool?)
  - `status` (CaptionStatus?)
  - `failureReason` (String?, only when status=failed)

**`packages/yt/lib/src/model/captions/caption_item.dart`**
- Extends `ResponseMetadata`
- Fields: `id` (String), `snippet` (CaptionSnippet?)

**`packages/yt/lib/src/model/captions/caption_list_response.dart`**
- Extends `ListResponse`
- Field: `captionItems` (List<CaptionItem>?) with `@JsonKey(name: 'items')`
- Getter: `List<CaptionItem> get items => captionItems ?? []`

### Step 2: Create Retrofit Client

**`packages/yt/lib/src/provider/data/captions.dart`**
- `@RestApi(baseUrl: 'https://www.googleapis.com')` — full paths per method
- Methods:
  - `@GET('/youtube/v3/captions')` → `list()` — returns `CaptionListResponse`
  - `@POST('/upload/youtube/v3/captions')` → `insert()` — accepts `FormData`, returns `CaptionItem`
  - `@PUT('/upload/youtube/v3/captions')` → `update()` — accepts `FormData`, returns `CaptionItem`
  - `@DELETE('/youtube/v3/captions')` → `delete()` — returns `void`
  - `@GET('/youtube/v3/captions/{id}')` → `download()` — returns `String` (plain text response)

Follow `VideoClient` pattern for dual standard/upload endpoints in a single client.

### Step 3: Create Domain Module

**`packages/yt/lib/src/captions.dart`**
- Extends `YouTubeApiHelper`, composes `CaptionClient`
- Methods:
  - `list(videoId, part, partList, onBehalfOfContentOwner)` — requires videoId
  - `insert(body, videoFile, part, partList, onBehalfOfContentOwner)` — builds FormData (JSON metadata + file), `@Deprecated` sync param
  - `update(body, videoFile, part, partList, onBehalfOfContentOwner)` — same as insert but for existing caption
  - `delete(id, onBehalfOfContentOwner)`
  - `download(id, tfmt, tlang, onBehalfOfContentOwner)` — returns plain text

### Step 4: Integrate into Yt class

**Modify `packages/yt/lib/src/yt_base.dart`:**
- Add `Captions? _captions;` field
- Add `Captions get captions => _captions!;` getter
- Initialize `_captions = Captions(dio: dio)` in `setModules()` (both tokenAuth and apiKey blocks, since list/download work with API key)

**Modify `packages/yt/lib/yt.dart`:**
- Export `captions.dart`
- Export all three caption model files

### Step 5: Create CLI Commands

**`packages/yt_cli/lib/src/cmd/youtube_captions_command.dart`**
- `YoutubeCaptionsCommand` (parent) with subcommands:
  - `list` — requires `--video-id`, supports `--part`, `--on-behalf-of-content-owner`
  - `insert` — requires `--video-id`, `--file` (caption file path), `--body` (JSON snippet)
  - `update` — requires `--caption-id`, `--file`, `--body`
  - `delete` — requires `--caption-id`
  - `download` — requires `--caption-id`, optional `--format` (tfmt), `--language` (tlang), `--output` (file path or stdout)

### Step 6: Register CLI

- **Modify `packages/yt_cli/lib/yt_cli.dart`** — add export
- **Modify `packages/yt_cli/bin/yt.dart`** — add `..addCommand(YoutubeCaptionsCommand())`
- **Modify `packages/yt_cli/lib/src/cmd/youtube_helper_command.dart`** — add `Captions get captions => _yt.captions;`

### Step 7: Generate & Verify

1. Run `dart run build_runner build` in `packages/yt/`
2. Run `dart analyze` — must pass with 0 issues
3. Test `dart run packages/yt_cli/bin/yt.dart captions --help`

## Files Summary

**Create (7 files):**
- `packages/yt/lib/src/model/captions/snippet.dart`
- `packages/yt/lib/src/model/captions/caption_item.dart`
- `packages/yt/lib/src/model/captions/caption_list_response.dart`
- `packages/yt/lib/src/provider/data/captions.dart`
- `packages/yt/lib/src/captions.dart`
- `packages/yt_cli/lib/src/cmd/youtube_captions_command.dart`

**Modify (5 files):**
- `packages/yt/lib/src/yt_base.dart`
- `packages/yt/lib/yt.dart`
- `packages/yt_cli/lib/yt_cli.dart`
- `packages/yt_cli/bin/yt.dart`
- `packages/yt_cli/lib/src/cmd/youtube_helper_command.dart`

**Generate (4 files via build_runner):**
- `captions.g.dart`, `caption_item.g.dart`, `caption_list_response.g.dart`, `snippet.g.dart`
