import 'dart:convert';

import 'package:universal_io/io.dart';

/// Shared security helpers for the CLI: input file path validation,
/// OAuth client-secret JSON schema validation, OAuth callback path
/// validation, and restrictive file permission enforcement on POSIX
/// platforms.
class SecurityUtil {
  SecurityUtil._();

  /// Validates a user-supplied file path and returns a resolved [File].
  ///
  /// Rejects:
  /// - empty paths
  /// - paths containing NUL bytes
  /// - paths that do not exist (when [mustExist] is true, the default)
  /// - paths that resolve to a non-regular file (directory, device, socket,
  ///   etc.) when the file exists
  ///
  /// [argName] is included in error messages to help the user identify which
  /// CLI argument is invalid. Throws [FormatException] on validation failure.
  static Future<File> validateInputFile(
    String path, {
    required String argName,
    bool mustExist = true,
  }) async {
    if (path.isEmpty) {
      throw FormatException('--$argName must not be empty.');
    }
    if (path.contains('\u0000')) {
      throw FormatException(
        '--$argName contains an embedded NUL byte and is not a valid path.',
      );
    }

    final file = File(path);
    if (mustExist) {
      final stat = await FileStat.stat(file.path);
      if (stat.type == FileSystemEntityType.notFound) {
        throw FormatException('File not found for --$argName: "$path".');
      }
      if (stat.type != FileSystemEntityType.file &&
          stat.type != FileSystemEntityType.link) {
        throw FormatException(
          '--$argName must point to a regular file (got ${stat.type}): "$path".',
        );
      }
    }
    return file;
  }

  /// Parses and validates an OAuth client-secret JSON document.
  ///
  /// Verifies the document is a JSON object containing either a `web` or
  /// `installed` root key, and that the nested object exposes the required
  /// string fields (`client_id`, `client_secret`, `auth_uri`, `token_uri`).
  ///
  /// Returns the inner config map. Throws [FormatException] on schema
  /// violations so callers can present a clear error to the user.
  static Map<String, dynamic> parseAndValidateClientSecret(String jsonString) {
    final dynamic decoded;
    try {
      decoded = jsonDecode(jsonString);
    } on FormatException catch (e) {
      throw FormatException('client_secret JSON is malformed: ${e.message}');
    }
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('client_secret JSON must be a JSON object.');
    }

    final rootKey = decoded.containsKey('web')
        ? 'web'
        : decoded.containsKey('installed')
        ? 'installed'
        : null;
    if (rootKey == null) {
      throw const FormatException(
        'client_secret JSON must contain a "web" or "installed" root key.',
      );
    }

    final config = decoded[rootKey];
    if (config is! Map<String, dynamic>) {
      throw FormatException(
        'client_secret JSON "$rootKey" entry must be a JSON object.',
      );
    }

    const requiredStringFields = [
      'client_id',
      'client_secret',
      'auth_uri',
      'token_uri',
    ];
    for (final field in requiredStringFields) {
      final value = config[field];
      if (value is! String || value.isEmpty) {
        throw FormatException(
          'client_secret JSON is missing required string field "$field".',
        );
      }
    }

    final redirectUris = config['redirect_uris'];
    if (redirectUris != null) {
      if (redirectUris is! List) {
        throw const FormatException(
          'client_secret JSON "redirect_uris" must be an array of strings.',
        );
      }
      for (final uri in redirectUris) {
        if (uri is! String || uri.isEmpty) {
          throw const FormatException(
            'client_secret JSON "redirect_uris" entries must be non-empty strings.',
          );
        }
      }
    }

    return config;
  }

  /// Validates an incoming OAuth callback URI against the registered redirect
  /// URI from the client-secret file.
  ///
  /// Ensures the callback path matches the expected path (defaulting to `/`
  /// when the redirect URI has no path) and that an authorization `code`
  /// query parameter is present and the response does not carry an `error`.
  ///
  /// Throws [FormatException] when the callback does not match.
  static void validateOAuthCallback({
    required Uri callback,
    required Uri expectedRedirect,
  }) {
    final expectedPath = expectedRedirect.path.isEmpty
        ? '/'
        : expectedRedirect.path;
    final actualPath = callback.path.isEmpty ? '/' : callback.path;

    if (actualPath != expectedPath) {
      throw FormatException(
        'OAuth callback path "$actualPath" does not match expected '
        'redirect path "$expectedPath".',
      );
    }

    final params = callback.queryParameters;
    if (params.containsKey('error')) {
      throw FormatException(
        'OAuth provider returned an error: ${params['error']}'
        '${params['error_description'] != null ? ' (${params['error_description']})' : ''}',
      );
    }
    if (!params.containsKey('code') || (params['code']?.isEmpty ?? true)) {
      throw const FormatException(
        'OAuth callback is missing the required "code" query parameter.',
      );
    }
  }

  /// Restricts a file to owner read/write only (mode 0600) on POSIX
  /// platforms. No-op on Windows, where ACLs are managed differently.
  ///
  /// Best-effort: failures are reported to stderr but do not abort the
  /// caller, since a missing or unavailable `chmod` should not block
  /// successful authorization.
  static Future<void> restrictFilePermissions(File file) async {
    if (Platform.isWindows) {
      return;
    }
    try {
      final result = await Process.run('chmod', ['600', file.path]);
      if (result.exitCode != 0) {
        stderr.writeln(
          'Warning: could not set restrictive permissions on '
          '"${file.path}": ${result.stderr}',
        );
      }
    } on ProcessException catch (e) {
      stderr.writeln(
        'Warning: could not run chmod on "${file.path}": ${e.message}',
      );
    }
  }
}
