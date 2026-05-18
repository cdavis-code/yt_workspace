/// Exception thrown when an authorization step fails.
///
/// Security: [toString] intentionally omits the wrapped [err] verbatim — the
/// underlying exception's `toString()` may contain access tokens, refresh
/// tokens, or full callback URLs (with `code=` / `access_token=` query
/// parameters). Only the cause's runtime type is exposed for diagnostics.
/// Use [debugDetails] when you explicitly need the raw underlying error
/// (e.g., from a sandboxed debug logger that you control).
class AuthorizationException implements Exception {
  final String msg;
  final Exception? err;

  const AuthorizationException([this.msg = '', this.err]);

  /// Returns the wrapped error in full. Caller-controlled — never log this
  /// in production.
  String debugDetails() => err == null ? msg : '$msg\n\n$err';

  @override
  String toString() {
    final cause = err == null ? '' : ' (cause: ${err.runtimeType})';
    return 'Authorization error: $msg$cause';
  }
}
