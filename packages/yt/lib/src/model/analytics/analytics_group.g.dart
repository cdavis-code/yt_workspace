// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsGroup _$AnalyticsGroupFromJson(Map<String, dynamic> json) =>
    AnalyticsGroup(
      kind: json['kind'] as String? ?? 'youtubeAnalytics#group',
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: AnalyticsGroupSnippet.fromJson(
        json['snippet'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AnalyticsGroupToJson(AnalyticsGroup instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };

AnalyticsGroupSnippet _$AnalyticsGroupSnippetFromJson(
  Map<String, dynamic> json,
) => AnalyticsGroupSnippet(title: json['title'] as String);

Map<String, dynamic> _$AnalyticsGroupSnippetToJson(
  AnalyticsGroupSnippet instance,
) => <String, dynamic>{'title': instance.title};
