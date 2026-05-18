import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:universal_io/io.dart' show File;
import 'package:yt/yt.dart';

part 'playlist_images.g.dart';

/// A [PlaylistImage] resource contains information about a custom playlist
/// image. The list and delete endpoints live on the standard YouTube Data
/// API base URL; insert and update use the resumable upload base URL and
/// are exposed via [PlaylistImagesUploadClient].
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class PlaylistImagesClient {
  factory PlaylistImagesClient(Dio dio, {String baseUrl}) =
      _PlaylistImagesClient;

  /// Returns a list of playlist images.
  @GET('/playlistImages')
  Future<PlaylistImageListResponse> list(
    @Header('Accept') String accept, {
    @Query('parent') String? parent,
    @Query('part') String? part,
    @Query('maxResults') int? maxResults,
    @Query('pageToken') String? pageToken,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Deletes a playlist image.
  @DELETE('/playlistImages')
  Future<void> delete(
    @Header('Accept') String accept,
    @Query('id') String id, {
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
  });
}

/// Resumable-upload endpoints for the [PlaylistImage] resource. Insert and
/// update both write to the upload base URL.
@RestApi(baseUrl: 'https://www.googleapis.com/upload/youtube/v3/playlistImages')
abstract class PlaylistImagesUploadClient {
  factory PlaylistImagesUploadClient(Dio dio, {String baseUrl}) =
      _PlaylistImagesUploadClient;

  /// Initiates a resumable upload session for the playlist image insert.
  @POST('')
  Future<HttpResponse<dynamic>> insertLocation(
    @Header('Accept') String accept,
    @Query('parent') String parent,
    @Query('uploadType') String uploadType, {
    @Query('part') String? part,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Uploads the image bytes for a new playlist image.
  @POST('')
  Future<PlaylistImage> insertUpload(
    @Header('Content-Type') String contentType,
    @Query('parent') String parent,
    @Query('upload_id') String uploadId,
    @Body() File image,
    @Query('uploadType') String uploadType,
  );

  /// Initiates a resumable upload session for the playlist image update.
  @PUT('')
  Future<HttpResponse<dynamic>> updateLocation(
    @Header('Accept') String accept,
    @Query('uploadType') String uploadType, {
    @Query('part') String? part,
    @Query('onBehalfOfContentOwner') String? onBehalfOfContentOwner,
    @Query('onBehalfOfContentOwnerChannel')
    String? onBehalfOfContentOwnerChannel,
  });

  /// Uploads the image bytes for an existing playlist image.
  @PUT('')
  Future<PlaylistImage> updateUpload(
    @Header('Content-Type') String contentType,
    @Query('upload_id') String uploadId,
    @Body() File image,
    @Query('uploadType') String uploadType,
  );
}
