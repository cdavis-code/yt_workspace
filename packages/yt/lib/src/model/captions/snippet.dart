import 'package:json_annotation/json_annotation.dart';

part 'snippet.g.dart';

/// The snippet object contains basic details about a caption track.
@JsonSerializable()
class CaptionSnippet {
  /// The ID that YouTube uses to uniquely identify the video for which the caption track was created.
  final String videoId;

  /// The date and time when the caption track was last updated.
  final DateTime? lastUpdated;

  /// The type of the caption track. Valid values are: standard, ASR.
  final String? trackKind;

  /// The language of the caption track. The value is a BCP-47 language tag.
  final String? language;

  /// The name of the caption track.
  final String? name;

  /// The type of audio track. Valid values are: main, descriptive, commentary, unknown.
  final String? audioTrackType;

  /// Indicates whether the caption track provides captions for the deaf or hard of hearing.
  final bool? isCC;

  /// Indicates whether the caption track uses large text for easy reading.
  final bool? isLarge;

  /// Indicates whether the caption track is in easy reader format.
  final bool? isEasyReader;

  /// Indicates whether the caption track is a draft.
  final bool? isDraft;

  /// Indicates whether the caption track was automatically synced.
  final bool? isAutoSynced;

  /// The caption track's status. Valid values are: serving, failed, syncing.
  final String? status;

  /// The reason that the caption track failed to process, if applicable.
  final String? failureReason;

  CaptionSnippet({
    required this.videoId,
    this.lastUpdated,
    this.trackKind,
    this.language,
    this.name,
    this.audioTrackType,
    this.isCC,
    this.isLarge,
    this.isEasyReader,
    this.isDraft,
    this.isAutoSynced,
    this.status,
    this.failureReason,
  });

  factory CaptionSnippet.fromJson(Map<String, dynamic> json) =>
      _$CaptionSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$CaptionSnippetToJson(this);
}
