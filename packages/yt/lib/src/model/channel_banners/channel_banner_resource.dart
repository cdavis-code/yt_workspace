import 'package:json_annotation/json_annotation.dart';

part 'channel_banner_resource.g.dart';

/// A channelBannerResource resource contains the URL that you would use
/// to set a newly uploaded image as the banner image for a channel.
@JsonSerializable()
class ChannelBannerResource {
  final String kind;
  final String? etag;

  /// The URL of this banner image. Set the channel resource's
  /// brandingSettings.image.bannerExternalUrl property to this value.
  final String? url;

  ChannelBannerResource({
    this.kind = 'youtube#channelBannerResource',
    this.etag,
    this.url,
  });

  factory ChannelBannerResource.fromJson(Map<String, dynamic> json) =>
      _$ChannelBannerResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelBannerResourceToJson(this);
}
