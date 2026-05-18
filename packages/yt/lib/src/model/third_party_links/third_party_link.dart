import 'package:json_annotation/json_annotation.dart';

import 'third_party_link_snippet.dart';
import 'third_party_link_status.dart';

part 'third_party_link.g.dart';

/// A thirdPartyLink resource represents a link between a YouTube channel
/// or video and an external resource, such as a merchandising store.
@JsonSerializable()
class ThirdPartyLink {
  final String kind;
  final String etag;

  /// The linking_token identifies a delegation relationship between an
  /// authenticated YouTube channel or content owner and a third-party
  /// linked resource.
  final String? linkingToken;

  /// The status object encapsulates information about the status of the
  /// link.
  final ThirdPartyLinkStatus? status;

  /// The snippet object contains basic details about the third-party link.
  final ThirdPartyLinkSnippet? snippet;

  ThirdPartyLink({
    this.kind = 'youtube#thirdPartyLink',
    required this.etag,
    this.linkingToken,
    this.status,
    this.snippet,
  });

  factory ThirdPartyLink.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ThirdPartyLinkToJson(this);
}
