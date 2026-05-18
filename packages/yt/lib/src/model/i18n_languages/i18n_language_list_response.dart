import 'package:json_annotation/json_annotation.dart';

import 'i18n_language.dart';

part 'i18n_language_list_response.g.dart';

@JsonSerializable()
class I18nLanguageListResponse {
  final String kind;
  final String etag;
  final List<I18nLanguage> items;

  I18nLanguageListResponse({
    this.kind = 'youtube#i18nLanguageListResponse',
    required this.etag,
    required this.items,
  });

  factory I18nLanguageListResponse.fromJson(Map<String, dynamic> json) =>
      _$I18nLanguageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$I18nLanguageListResponseToJson(this);
}
