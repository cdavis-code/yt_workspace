import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'third_party_links.g.dart';

/// A thirdPartyLink resource represents a link between a YouTube channel
/// or video and an external resource.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class ThirdPartyLinksClient {
  factory ThirdPartyLinksClient(Dio dio, {String baseUrl}) =
      _ThirdPartyLinksClient;

  /// Returns a list of third-party links of the specified type that match
  /// the API request criteria.
  @GET('/thirdPartyLinks')
  Future<ThirdPartyLinkListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('externalChannelId') String? externalChannelId,
    @Query('linkingToken') String? linkingToken,
    @Query('type') String? type,
  });

  /// Posts a third-party link to a YouTube channel.
  @POST('/thirdPartyLinks')
  Future<ThirdPartyLink> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('externalChannelId') String? externalChannelId,
  });

  /// Updates an existing third-party link.
  @PUT('/thirdPartyLinks')
  Future<ThirdPartyLink> update(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('externalChannelId') String? externalChannelId,
  });

  /// Deletes a third-party link.
  @DELETE('/thirdPartyLinks')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('linkingToken') String linkingToken,
    @Query('type') String type, {
    @Query('part') String? part,
    @Query('externalChannelId') String? externalChannelId,
  });
}
