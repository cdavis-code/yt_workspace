import 'package:json_annotation/json_annotation.dart';

part 'i18n_region_snippet.g.dart';

/// The snippet object contains basic details about the i18n region.
@JsonSerializable()
class I18nRegionSnippet {
  /// The region code, which is a two-letter ISO country code that identifies the region.
  final String gl;

  /// The human-readable name of the region.
  final String name;

  I18nRegionSnippet({required this.gl, required this.name});

  factory I18nRegionSnippet.fromJson(Map<String, dynamic> json) =>
      _$I18nRegionSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$I18nRegionSnippetToJson(this);
}
