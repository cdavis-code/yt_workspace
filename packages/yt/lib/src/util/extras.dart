import 'package:dio/dio.dart';

extension UsageExtension on DioException {
  String get usage {
    return response?.data == '' || response?.data['error']['errors'] == null
        ? message ?? ''
        : response!.data['error']['errors'].toString();
  }
}
