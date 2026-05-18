import 'package:universal_io/io.dart';
import 'package:yt/src/youtube_api_helper.dart';
import 'package:yt/yt.dart';

import 'provider/data/playlist_images.dart';

/// A [PlaylistImage] resource contains information about a custom playlist
/// image. The API supports the ability to create, read, update, and delete
/// these images.
class PlaylistImages extends YouTubeApiHelper {
  final PlaylistImagesClient _rest;
  final PlaylistImagesUploadClient _uploadRest;

  PlaylistImages({required super.dio})
    : _rest = PlaylistImagesClient(dio),
      _uploadRest = PlaylistImagesUploadClient(dio);

  /// Returns a list of playlist images for the given playlist.
  Future<PlaylistImageListResponse> list({
    required String parent,
    String part = 'snippet',
    List<String> partList = const [],
    int? maxResults,
    String? pageToken,
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async => _rest.list(
    accept,
    parent: parent,
    part: buildParts(partList, part),
    maxResults: maxResults,
    pageToken: pageToken,
    onBehalfOfContentOwner: onBehalfOfContentOwner,
    onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
  );

  /// Uploads a custom playlist image and associates it with the given
  /// playlist via a resumable upload session.
  Future<PlaylistImage> insert({
    required String parent,
    required File image,
    String part = 'snippet',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    const uploadType = 'resumable';

    final httpResponse = await _uploadRest.insertLocation(
      accept,
      parent,
      uploadType,
      part: buildParts(partList, part),
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );

    final location = httpResponse.response.headers.value('location');
    if (location == null) {
      throw Exception(
        'Upload location for the playlist image could not be determined',
      );
    }

    final uploadUri = Uri.parse(location);
    final uploadId = uploadUri.queryParameters['upload_id'];
    if (uploadId == null) {
      throw Exception(
        'Upload Id for the playlist image could not be determined',
      );
    }

    return _uploadRest.insertUpload(
      'application/x-www-form-urlencoded',
      parent,
      uploadId,
      image,
      uploadType,
    );
  }

  /// Replaces the image bytes for an existing playlist image via a
  /// resumable upload session.
  Future<PlaylistImage> update({
    required File image,
    String part = 'id,snippet',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    String? onBehalfOfContentOwnerChannel,
  }) async {
    const uploadType = 'resumable';

    final httpResponse = await _uploadRest.updateLocation(
      accept,
      uploadType,
      part: buildParts(partList, part),
      onBehalfOfContentOwner: onBehalfOfContentOwner,
      onBehalfOfContentOwnerChannel: onBehalfOfContentOwnerChannel,
    );

    final location = httpResponse.response.headers.value('location');
    if (location == null) {
      throw Exception(
        'Upload location for the playlist image could not be determined',
      );
    }

    final uploadUri = Uri.parse(location);
    final uploadId = uploadUri.queryParameters['upload_id'];
    if (uploadId == null) {
      throw Exception(
        'Upload Id for the playlist image could not be determined',
      );
    }

    return _uploadRest.updateUpload(
      'application/x-www-form-urlencoded',
      uploadId,
      image,
      uploadType,
    );
  }

  /// Deletes the playlist image identified by [id].
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
  }) async =>
      _rest.delete(accept, id, onBehalfOfContentOwner: onBehalfOfContentOwner);
}
