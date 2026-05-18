import 'package:json_annotation/json_annotation.dart';

import 'channel_to_store_link.dart';

part 'third_party_link_snippet.g.dart';

/// The snippet object contains basic details about the third-party
/// account link.
@JsonSerializable()
class ThirdPartyLinkSnippet {
  /// Type of the link named after the entities that are being linked.
  /// Currently only `channelToStoreLink` is supported.
  final String? type;

  /// Information specific to a link between a channel and a store on a
  /// merchandising platform.
  final ChannelToStoreLink? channelToStoreLink;

  ThirdPartyLinkSnippet({this.type, this.channelToStoreLink});

  factory ThirdPartyLinkSnippet.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyLinkSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$ThirdPartyLinkSnippetToJson(this);
}
