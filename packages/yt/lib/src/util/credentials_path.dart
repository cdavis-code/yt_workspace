import 'package:universal_io/io.dart';

import 'util.dart';

/// Helpers for resolving the file paths used to load and persist OAuth
/// credentials.
///
/// Two environment variables are supported, each pointing at an exact file:
///   * `YT_CLIENT_SECRETS_FILE` — the OAuth client-secret JSON file.
///   * `YT_ACCESS_TOKENS_FILE` — the persisted access/refresh token JSON file.
///
/// Each variable may come from the runtime environment or a `.env` file in
/// the current working directory. When neither source provides a value, the
/// caller-supplied default path is used. Leading `~` is expanded against the
/// user's home directory in all cases.
class CredentialsPath {
  static final String? _userHome =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];

  /// Resolves a single credential file path from [envVarName].
  ///
  /// Resolution order:
  ///   1. [envVarName] from the runtime environment
  ///   2. [envVarName] from a `.env` file in the current working directory
  ///   3. [defaultPath]
  ///
  /// Leading `~` in the resolved value is expanded against the user's home
  /// directory.
  static String resolveFile(String envVarName, {required String defaultPath}) {
    final fromEnv = Platform.environment[envVarName];
    if (fromEnv != null && fromEnv.isNotEmpty) {
      return expandHome(fromEnv);
    }

    final fromDotEnv = readFromDotEnv(envVarName);
    if (fromDotEnv != null && fromDotEnv.isNotEmpty) {
      return expandHome(fromDotEnv);
    }

    return expandHome(defaultPath);
  }

  /// Resolves the path to the OAuth client-secret JSON file using
  /// `YT_CLIENT_SECRETS_FILE`, falling back to [defaultPath].
  static String clientSecretsFile({required String defaultPath}) =>
      resolveFile(Util.envYtClientSecretsFile, defaultPath: defaultPath);

  /// Resolves the path to the persisted access/refresh token JSON file using
  /// `YT_ACCESS_TOKENS_FILE`, falling back to [defaultPath].
  static String accessTokensFile({required String defaultPath}) =>
      resolveFile(Util.envYtAccessTokensFile, defaultPath: defaultPath);

  /// Resolves a configuration value from environment or `.env` file.
  ///
  /// Returns the value from the runtime environment if set, otherwise
  /// from the `.env` file, otherwise `null`.
  static String? resolveValue(String envVarName) {
    final fromEnv = Platform.environment[envVarName];
    if (fromEnv != null && fromEnv.isNotEmpty) {
      return fromEnv;
    }

    final fromDotEnv = readFromDotEnv(envVarName);
    if (fromDotEnv != null && fromDotEnv.isNotEmpty) {
      return fromDotEnv;
    }

    return null;
  }

  /// Expands a leading `~` in [path] to the current user's home directory.
  static String expandHome(String path) {
    if (path == '~') return _userHome ?? path;
    if (path.startsWith('~/')) {
      return '${_userHome ?? ''}${path.substring(1)}';
    }
    return path;
  }

  /// Reads [key] from a `.env` file in the current working directory.
  ///
  /// Supports `KEY=value` lines with optional surrounding single or double
  /// quotes. Lines starting with `#` and blank lines are ignored. Returns
  /// `null` when the file is missing, unreadable, or does not contain [key].
  ///
  /// **Trust boundary** — `.env` is read from `Directory.current`, so any
  /// process that can change the working directory (e.g. a CI job, a script
  /// invoked from an attacker-controlled checkout) can supply credentials
  /// pointers. Set the `YT_DISABLE_DOTENV` environment variable to a
  /// truthy value (`1`, `true`, `yes`) to disable `.env` lookup entirely
  /// and force resolution to honor only real environment variables.
  static String? readFromDotEnv(String key) {
    if (_dotEnvDisabled()) return null;
    try {
      final envFile = File('.env');
      if (!envFile.existsSync()) return null;

      for (final line in envFile.readAsLinesSync()) {
        final trimmed = line.trim();
        if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

        final equalsIndex = trimmed.indexOf('=');
        if (equalsIndex <= 0) continue;

        final lineKey = trimmed.substring(0, equalsIndex).trim();
        if (lineKey != key) continue;

        var value = trimmed.substring(equalsIndex + 1).trim();
        if (value.length >= 2 &&
            ((value.startsWith('"') && value.endsWith('"')) ||
                (value.startsWith("'") && value.endsWith("'")))) {
          value = value.substring(1, value.length - 1);
        }
        return value;
      }
    } catch (_) {
      // Non-fatal — treat any error as "not configured".
    }
    return null;
  }

  static bool _dotEnvDisabled() {
    final flag = Platform.environment['YT_DISABLE_DOTENV']?.toLowerCase();
    return flag == '1' || flag == 'true' || flag == 'yes';
  }
}
