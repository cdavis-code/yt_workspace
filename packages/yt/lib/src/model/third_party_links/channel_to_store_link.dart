import 'package:json_annotation/json_annotation.dart';

part 'channel_to_store_link.g.dart';

/// The channelToStoreLink object identifies the merchant store linked to
/// the channel. Only one merchant store can be linked to a channel.
@JsonSerializable()
class ChannelToStoreLink {
  /// The name of the merchant store.
  final String? storeName;

  /// The URL of the merchant store.
  final String? storeUrl;

  ChannelToStoreLink({this.storeName, this.storeUrl});

  factory ChannelToStoreLink.fromJson(Map<String, dynamic> json) =>
      _$ChannelToStoreLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToStoreLinkToJson(this);
}
