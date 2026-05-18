import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'channel_sections.g.dart';

/// A channelSection resource represents a section of a channel's main page.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class ChannelSectionsClient {
  factory ChannelSectionsClient(Dio dio, {String baseUrl}) =
      _ChannelSectionsClient;

  /// Returns a list of channelSection resources that match the API request criteria.
  @GET('/channelSections')
  Future<ChannelSectionListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String part, {
    @Query('channelId') String? channelId,
    @Query('id') String? id,
    @Query('mine') bool? mine,
    @Query('hl') String? hl,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  /// Adds a channel section to the authenticated user's channel.
  @POST('/channelSections')
  Future<ChannelSection> insert(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Updates a channel section.
  @PUT('/channelSections')
  Future<ChannelSection> update(
    @Header('Accept') String accept,
    @Header('Content-Type') String contentType,
    @Query('part') String part,
    @Body() Map<String, dynamic> body, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  /// Deletes a channel section.
  @DELETE('/channelSections')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
