import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../localized.dart';
import '../thumbnails.dart';

part 'snippet.g.dart';

///The [Snippet] object contains basic details about the channel, such as its title, description, and thumbnail images.
@JsonSerializable(explicitToJson: true)
class Snippet {
  ///The channel's title.
  final String title;

  ///The channel's description. The property's value has a maximum length of 1000 characters.
  final String description;

  ///The channel's custom URL. The [YouTube Help Center](https://support.google.com/youtube/answer/2657968) explains eligibility requirements for getting a custom URL as well as how to set up the URL.
  final String? customUrl;

  ///The date and time that the channel was created. The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime) format.
  final DateTime? publishedAt;

  ///A map of thumbnail images associated with the channel. For each object in the map, the key is the name of the thumbnail image, and the value is an object that contains other information about the thumbnail.
  ///
  ///When displaying thumbnails in your application, make sure that your code uses the image URLs exactly as they are returned in API responses. For example, your application should not use the http domain instead of the https domain in a URL returned in an API response.
  ///
  ///Channel thumbnail URLs are available only in the https domain, which is how the URLs appear in API responses. You might see broken images in your application if it tries to load YouTube images from the http domain. Thumbnail images might be empty for newly created channels and might take up to one day to populate.
  final Thumbnails? thumbnails;

  ///The language of the text in the channel resource's snippet.title and snippet.description properties.
  final String? defaultLanguage;

  ///The [Snippet.localized] object contains either a localized title and description for the video or the title in the default language for the video's metadata.
  ///Localized text is returned in the resource snippet if the videos.list request used the hl parameter to specify a language for which localized text should be returned and localized text is available in that language.
  ///Metadata for the default language is returned if an hl parameter value is not specified or a value is specified but localized metadata is not available for the specified language.
  ///The property contains a read-only value. Use the localizations object to add, update, or delete localized titles.
  final Localized? localized;

  ///The country with which the channel is associated. To set this property's value, update the value of the brandingSettings.channel.country property.
  final String? country;

  Snippet({
    required this.title,
    required this.description,
    this.customUrl,
    this.publishedAt,
    this.thumbnails,
    this.defaultLanguage,
    this.localized,
    this.country,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
