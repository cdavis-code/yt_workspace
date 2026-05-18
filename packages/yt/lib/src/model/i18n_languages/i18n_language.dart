import 'package:json_annotation/json_annotation.dart';

import 'i18n_language_snippet.dart';

part 'i18n_language.g.dart';

/// An i18nLanguage resource identifies an application language that the
/// YouTube website supports. The application language can also be referred
/// to as a UI language.
@JsonSerializable()
class I18nLanguage {
  final String kind;
  final String etag;
  final String id;
  final I18nLanguageSnippet snippet;

  I18nLanguage({
    this.kind = 'youtube#i18nLanguage',
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory I18nLanguage.fromJson(Map<String, dynamic> json) =>
      _$I18nLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$I18nLanguageToJson(this);
}
