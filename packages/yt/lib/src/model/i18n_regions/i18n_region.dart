import 'package:json_annotation/json_annotation.dart';

import 'i18n_region_snippet.dart';

part 'i18n_region.g.dart';

/// An i18nRegion resource identifies a geographic area that a YouTube user
/// can select as the preferred content region.
@JsonSerializable()
class I18nRegion {
  final String kind;
  final String etag;
  final String id;
  final I18nRegionSnippet snippet;

  I18nRegion({
    this.kind = 'youtube#i18nRegion',
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory I18nRegion.fromJson(Map<String, dynamic> json) =>
      _$I18nRegionFromJson(json);

  Map<String, dynamic> toJson() => _$I18nRegionToJson(this);
}
