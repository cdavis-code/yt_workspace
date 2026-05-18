import 'package:json_annotation/json_annotation.dart';

import 'i18n_region.dart';

part 'i18n_region_list_response.g.dart';

@JsonSerializable()
class I18nRegionListResponse {
  final String kind;
  final String etag;
  final List<I18nRegion> items;

  I18nRegionListResponse({
    this.kind = 'youtube#i18nRegionListResponse',
    required this.etag,
    required this.items,
  });

  factory I18nRegionListResponse.fromJson(Map<String, dynamic> json) =>
      _$I18nRegionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$I18nRegionListResponseToJson(this);
}
