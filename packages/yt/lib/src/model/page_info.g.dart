// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
  totalResults: (json['totalResults'] as num).toInt(),
  resultsPerPage: (json['resultsPerPage'] as num).toInt(),
);

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
  'totalResults': instance.totalResults,
  'resultsPerPage': instance.resultsPerPage,
};
