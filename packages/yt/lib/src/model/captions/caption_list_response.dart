import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../list_response.dart';
import 'caption_item.dart';

part 'caption_list_response.g.dart';

/// A paginated list of caption resources.
@JsonSerializable()
class CaptionListResponse extends ListResponse {
  /// A list of captions that match the request criteria.
  @JsonKey(name: 'items')
  final List<CaptionItem>? captionItems;

  CaptionListResponse({
    required super.kind,
    required super.etag,
    super.nextPageToken,
    super.prevPageToken,
    super.pageInfo,
    this.captionItems,
  });

  List<CaptionItem> get items => captionItems ?? [];

  factory CaptionListResponse.fromJson(Map<String, dynamic> json) =>
      _$CaptionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CaptionListResponseToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
