import 'dart:async';

import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';

/// Dio instance may have one or more interceptors by which you can intercept
/// requests/responses/errors before they are handled by `then` or `catchError`.
///
/// Security: Authorization headers and API-key query parameters are redacted
/// from logs to prevent credential leakage. Responses larger than
/// [maxResponseBytes] are rejected to bound memory exposure from a
/// misbehaving or hostile upstream.
class LoggingInterceptors extends Interceptor with UiLoggy {
  /// Default maximum permitted response body size (50 MiB). YouTube API
  /// responses are JSON metadata; binary uploads are sent in the request
  /// direction, so 50 MiB is a generous defensive cap.
  static const int defaultMaxResponseBytes = 50 * 1024 * 1024;

  /// Hard limit on response body size. Exceeding this raises a [DioException]
  /// of type [DioExceptionType.badResponse] before the body reaches callers.
  final int maxResponseBytes;

  LoggingInterceptors({this.maxResponseBytes = defaultMaxResponseBytes});

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
    final declared = _declaredContentLength(response);
    if (declared != null && declared > maxResponseBytes) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Response body size ($declared bytes) exceeds the maximum '
              'permitted ($maxResponseBytes bytes).',
        ),
      );
      return null;
    }

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

  /// Best-effort parse of the `Content-Length` response header. Returns null
  /// when absent or unparsable (e.g. chunked transfer-encoding).
  static int? _declaredContentLength(Response<dynamic> response) {
    final values = response.headers.value(Headers.contentLengthHeader);
    if (values == null) return null;
    return int.tryParse(values);
  }
}
