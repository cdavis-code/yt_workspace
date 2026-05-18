import 'package:dio/dio.dart';

abstract class YouTubeApiHelper {
  final String? token;
  final String? apiKey;
  final Dio dio;

  final accept = 'application/json';

  final contentType = 'application/json';

  YouTubeApiHelper({required this.dio, this.token, this.apiKey});

  String buildParts(List<String> partList, String part) {
    if (partList.isEmpty && part == '') {
      throw ArgumentError('Either partList or part must be provided.');
    }

    final List<String> tmpList = [];

    tmpList.addAll(partList);

    tmpList.addAll(part.trim().split(','));

    return tmpList.toSet().toList().join(',');
  }
}
