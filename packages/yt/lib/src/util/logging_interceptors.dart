import 'dart:async';

import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';

/// Dio instance may have one or more interceptors by which you can intercept
/// requests/responses/errors before they are handled by `then` or `catchError`.
///
/// Security: Authorization headers and API-key query parameters are redacted
/// from logs to prevent credential leakage.
class LoggingInterceptors extends Interceptor with UiLoggy {
  /// The callback will be executed before the request is initiated.
  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    loggy.debug('URI: ${_sanitizeUri(options.uri)}');

    loggy.debug('HEADERS:\n${_sanitizeHeaders(options.headers)}');

    loggy.debug('REQUEST:\n${options.data}');

    handler.next(options);
  }

  /// The callback will be executed on error.
  @override
  FutureOr<dynamic> onError(DioException err, ErrorInterceptorHandler handler) {
    loggy.error('ERROR:\n${err.message ?? err.type}');

    handler.next(err);
  }

  /// The callback will be executed on success.
  @override
  FutureOr<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    loggy.debug('RESPONSE:\n${_truncateBody(response.data)}');

    handler.next(response);
  }

  /// Strips sensitive headers before logging.
  static Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    final sanitized = Map<String, dynamic>.from(headers);
    sanitized.remove('Authorization');
    sanitized.remove('authorization');
    sanitized.remove('x-goog-api-key');
    return sanitized;
  }

  /// Redacts API key and token query parameters from the URI before logging.
  static Uri _sanitizeUri(Uri uri) {
    final params = Map<String, String>.from(uri.queryParameters);
    params.remove('key');
    params.remove('access_token');
    if (params.isEmpty) return uri.replace(query: null);
    return uri.replace(queryParameters: params);
  }

  /// Truncates large response bodies to avoid flooding logs.
  static String _truncateBody(dynamic data) {
    final s = data?.toString() ?? '';
    if (s.length > 500) return '${s.substring(0, 500)}... [truncated]';
    return s;
  }
}
