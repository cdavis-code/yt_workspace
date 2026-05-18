import 'package:json_annotation/json_annotation.dart';

part 'i18n_language_snippet.g.dart';

/// The snippet object contains basic details about the i18n language.
@JsonSerializable()
class I18nLanguageSnippet {
  /// A short BCP-47 code that uniquely identifies a language.
  final String hl;

  /// The human-readable name of the language in the language itself.
  final String name;

  I18nLanguageSnippet({required this.hl, required this.name});

  factory I18nLanguageSnippet.fromJson(Map<String, dynamic> json) =>
      _$I18nLanguageSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$I18nLanguageSnippetToJson(this);
}
