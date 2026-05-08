import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/captions/caption_item.dart';
import '../../model/captions/caption_list_response.dart';

part 'captions.g.dart';

/// A caption resource contains information about a YouTube video caption track.
@RestApi(baseUrl: 'https://www.googleapis.com')
abstract class CaptionClient {
  factory CaptionClient(Dio dio, {String baseUrl}) = _CaptionClient;

  /// Returns a list of caption resources that match the API request criteria.
  @GET('/youtube/v3/captions')
  Future<CaptionListResponse> list(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('videoId') required String videoId,
    @Query('id') String? id,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  /// Uploads a caption track.
  @POST('/upload/youtube/v3/captions')
  Future<CaptionItem> insert(
    @Header('Accept') String accept,
    @Query('part') String parts,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Deprecated('The sync parameter was deprecated on March 13, 2024')
    @Query('sync') bool? sync,
    @Body() FormData formData,
  );

  /// Updates a caption track.
  @PUT('/upload/youtube/v3/captions')
  Future<CaptionItem> update(
    @Header('Accept') String accept,
    @Query('part') String parts,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Deprecated('The sync parameter was deprecated on March 13, 2024')
    @Query('sync') bool? sync,
    @Body() FormData formData,
  );

  /// Deletes a caption track.
  @DELETE('/youtube/v3/captions')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });

  /// Downloads a caption track.
  @GET('/youtube/v3/captions/{id}')
  Future<String> download(
    @Query('key') String? apiKey,
    @Header('Accept') String accept,
    @Path('id') String id, {
    @Query('tfmt') String? tfmt,
    @Query('tlang') String? tlang,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}
