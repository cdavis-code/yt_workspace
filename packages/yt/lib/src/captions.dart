import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:universal_io/io.dart';
import 'package:yt/yt.dart';

import 'provider/data/captions.dart';

/// A caption resource contains information about a YouTube video caption track.
///
/// Captions are available in many different languages.
class Captions extends YouTubeApiHelper {
  final CaptionClient _rest;

  Captions({required super.dio, super.apiKey})
    : _rest = CaptionClient(dio);

  /// Returns a list of caption resources that match the API request criteria.
  Future<CaptionListResponse> list({
    String part = 'id,snippet',
    List<String> partList = const [],
    required String videoId,
    String? id,
    String? onBehalfOfContentOwner,
  }) async {
    return _rest.list(
      apiKey,
      accept,
      buildParts(partList, part),
      videoId: videoId,
      id: id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  /// Uploads a caption track to YouTube.
  ///
  /// The [body] parameter contains the caption resource metadata (snippet).
  /// The [captionFile] is the caption file (.srt, .vtt, .ass, etc.).
  ///
  /// Supported MIME types for the caption file: text/vtt, text/plain,
  /// application/octet-stream.
  ///
  /// Note: The `sync` parameter was deprecated on March 13, 2024.
  Future<CaptionItem> insert({
    required Map<String, dynamic> body,
    required File captionFile,
    String part = 'snippet',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    @Deprecated('The sync parameter was deprecated on March 13, 2024')
    bool? sync,
  }) async {
    final formData = FormData.fromMap({
      'snippet': MultipartFile.fromString(
        jsonEncode(body),
        contentType: DioMediaType.parse('application/json'),
      ),
      'file': await MultipartFile.fromFile(captionFile.path),
    });

    return _rest.insert(
      accept,
      buildParts(partList, part),
      onBehalfOfContentOwner,
      sync,
      formData,
    );
  }

  /// Updates a caption track's metadata and/or file.
  ///
  /// The [body] parameter must include the caption `id` and updated `snippet`.
  /// The [captionFile] is the updated caption file.
  Future<CaptionItem> update({
    required Map<String, dynamic> body,
    required File captionFile,
    String part = 'snippet',
    List<String> partList = const [],
    String? onBehalfOfContentOwner,
    @Deprecated('The sync parameter was deprecated on March 13, 2024')
    bool? sync,
  }) async {
    final formData = FormData.fromMap({
      'snippet': MultipartFile.fromString(
        jsonEncode(body),
        contentType: DioMediaType.parse('application/json'),
      ),
      'file': await MultipartFile.fromFile(captionFile.path),
    });

    return _rest.update(
      accept,
      buildParts(partList, part),
      onBehalfOfContentOwner,
      sync,
      formData,
    );
  }

  /// Deletes a caption track.
  Future<void> delete({
    required String id,
    String? onBehalfOfContentOwner,
  }) async {
    return _rest.delete(
      accept,
      id,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }

  /// Downloads a caption track.
  ///
  /// Returns the caption content as a string in the specified format.
  ///
  /// [tfmt] - The format of the caption: 'srt', 'vtt', 'sbv', etc.
  /// [tlang] - BCP-47 language code for auto-translated captions.
  Future<String> download({
    required String id,
    String? tfmt,
    String? tlang,
    String? onBehalfOfContentOwner,
  }) async {
    return _rest.download(
      apiKey,
      'text/plain',
      id,
      tfmt: tfmt,
      tlang: tlang,
      onBehalfOfContentOwner: onBehalfOfContentOwner,
    );
  }
}
