import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../localized.dart';
import '../thumbnails.dart';

part 'snippet.g.dart';

/// The [Snippet] object contains basic details about the video, such as its title, description, and category.
@JsonSerializable(explicitToJson: true)
class Snippet {
  /// The date and time that the video was published. Note that this time might be different than the time that the video was uploaded. For example, if a video is uploaded as a private video and then made public at a later time, this property will specify the time that the video was made public.
  ///
  /// There are a couple of special cases:
  /// - If a video is uploaded as a private video and the video metadata is retrieved by the channel owner, then the property value specifies the date and time that the video was uploaded.
  /// - If a video is uploaded as an unlisted video, the property value also specifies the date and time that the video was uploaded. In this case, anyone who knows the video's unique video ID can retrieve the video metadata.
  /// The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) format.
  final DateTime? publishedAt;

  /// The ID that YouTube uses to uniquely identify the channel that the video was uploaded to.
  final String? channelId;

  /// The video's title. The property value has a maximum length of 100 characters and may contain all valid UTF-8 characters except < and >. You must set a value for this property if you call the videos.update method and are updating the [Snippet] part of a video resource.
  final String title;

  /// The video's description. The property value has a maximum length of 5000 bytes and may contain all valid UTF-8 characters except < and >.
  final String description;

  /// A map of thumbnail images associated with the video. For each object in the map, the key is the name of the thumbnail image, and the value is an object that contains other information about the thumbnail.
  final Thumbnails? thumbnails;

  ///Channel title for the channel that the video belongs to.
  final String? channelTitle;

  ///A list of keyword tags associated with the video. Tags may contain spaces. The property value has a maximum length of 500 characters. Note the following rules regarding the way the character limit is calculated:
  ///- The property value is a list, and commas between items in the list count toward the limit.
  ///- If a tag contains a space, the API server handles the tag value as though it were wrapped in quotation marks, and the quotation marks count toward the character limit. So, for the purposes of character limits, the tag Foo-Baz contains seven characters, but the tag Foo Baz contains nine characters.
  final List<String>? tags;

  ///The YouTube [video category](https://developers.google.com/youtube/v3/docs/videoCategories/list) associated with the video. You must set a value for this property if you call the videos.update method and are updating the [Snippet] part of a video resource.
  final String? categoryId;

  ///Indicates if the video is an upcoming/active live broadcast. Or it's "none" if the video is not an upcoming/active live broadcast.
  ///
  ///Valid values for this property are:
  ///- live
  ///- none
  ///- upcoming
  final String liveBroadcastContent;

  ///The language of the text in the video resource's [Snippet.title] and [Snippet.description] properties.
  final String? defaultLanguage;

  ///The [Snippet.localized] object contains either a localized title and description for the video or the title in the default language for the video's metadata.
  ///Localized text is returned in the resource snippet if the videos.list request used the hl parameter to specify a language for which localized text should be returned and localized text is available in that language.
  ///Metadata for the default language is returned if an hl parameter value is not specified or a value is specified but localized metadata is not available for the specified language.
  ///The property contains a read-only value. Use the localizations object to add, update, or delete localized titles.
  final Localized? localized;

  ///The default_audio_language property specifies the language spoken in the video's default audio track.
  final String? defaultAudioLanguage;

  Snippet({
    this.publishedAt,
    this.channelId,
    required this.title,
    required this.description,
    this.thumbnails,
    this.channelTitle,
    this.tags,
    this.categoryId,
    required this.liveBroadcastContent,
    this.defaultLanguage,
    this.localized,
    this.defaultAudioLanguage,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
