import 'package:universal_io/io.dart';
import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/channel_banners.dart';

/// A [ChannelBannerResource] resource contains the URL that you would
/// use to set a newly uploaded image as the banner image for a channel.
///
/// The workflow for setting a banner is:
///   1. Call [insert] with the image file. The returned resource contains
///      a `url`.
///   2. Pass that `url` to [Channels.update] in the
///      `brandingSettings.image.bannerExternalUrl` field for the channel
///      whose banner is being updated.
class ChannelBanners extends YouTubeApiHelper {
  final ChannelBannersClient _rest;

  ChannelBanners({required super.dio}) : _rest = ChannelBannersClient(dio);

  /// Uploads a channel banner image to YouTube via a resumable upload
  /// session and returns the resulting [ChannelBannerResource].
  Future<ChannelBannerResource> insert({
    required File image,
    String? channelId,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    const uploadType = 'resumable';

    final httpResponse = await _rest.location(
      accept,
      uploadType,
      channelId: channelId,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );

    final location = httpResponse.response.headers.value('location');
    if (location == null) {
      throw Exception(
        'Upload location for the channel banner could not be determined',
      );
    }

    final uploadUri = Uri.parse(location);
    final uploadId = uploadUri.queryParameters['upload_id'];
    if (uploadId == null) {
      throw Exception(
        'Upload Id for the channel banner could not be determined',
      );
    }

    return _rest.upload(
      'application/x-www-form-urlencoded',
      uploadId,
      image,
      uploadType,
    );
  }
}
