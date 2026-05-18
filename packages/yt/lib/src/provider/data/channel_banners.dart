import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:universal_io/io.dart' show File;
import 'package:yt/yt.dart';

part 'channel_banners.g.dart';

/// The channelBanners resource lets you upload a banner image for a
/// channel. The URL returned by the upload can then be assigned to the
/// channel resource's `brandingSettings.image.bannerExternalUrl` property.
@RestApi(baseUrl: 'https://www.googleapis.com/upload/youtube/v3/channelBanners')
abstract class ChannelBannersClient {
  factory ChannelBannersClient(Dio dio, {String baseUrl}) =
      _ChannelBannersClient;

  /// Initiates a resumable upload session for a channel banner.
  @POST('/insert')
  Future<HttpResponse<dynamic>> location(
    @Header('Accept') String accept,
    @Query('uploadType') String uploadType, {
    @Query('channelId') String? channelId,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Uploads the channel banner image bytes.
  @POST('/insert')
  Future<ChannelBannerResource> upload(
    @Header('Content-Type') String contentType,
    @Query('upload_id') String uploadId,
    @Body() File image,
    @Query('uploadType') String uploadType,
  );
}
