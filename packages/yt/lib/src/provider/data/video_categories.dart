import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yt/yt.dart';

part 'video_categories.g.dart';

///A videoCategory resource identifies a category that has been or could be associated with uploaded videos.
@RestApi(baseUrl: 'https://www.googleapis.com/youtube/v3')
abstract class VideoCategoriesClient {
  factory VideoCategoriesClient(Dio dio, {String baseUrl}) =
      _VideoCategoriesClient;

  ///Returns a list of [VideoItem]s that match the API request parameters.
  @GET('/videoCategories')
  Future<VideoCategoryListResponse> list(
    @Header('Accept') String accept,
    @Query('part') String parts, {
    @Query('id') String? id,
    @Query('regionCode') String? regionCode,
    @Query('hl') String? hl,
  });
}
