import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  String? scope;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  Token({
    required this.accessToken,
    required this.expiresIn,
    this.scope,
    required this.tokenType,
    this.refreshToken,
  }) {
    // OAuth 2.0 RFC 6749 §5.1: `expires_in` is RECOMMENDED and, when
    // present, MUST be a non-negative number of seconds. Reject obviously
    // malformed values up front so callers don't compute a refresh
    // schedule from negative durations or absurdly large futures.
    if (expiresIn < 0) {
      throw ArgumentError.value(
        expiresIn,
        'expiresIn',
        'Token expires_in must be non-negative.',
      );
    }
    // 1 year cap — a useful sanity bound; YouTube/Google access tokens
    // are typically 3600s and refresh tokens never appear here as
    // `expires_in`. A larger value almost always indicates a malformed
    // server response or test fixture mistake.
    const maxSeconds = 365 * 24 * 60 * 60;
    if (expiresIn > maxSeconds) {
      throw ArgumentError.value(
        expiresIn,
        'expiresIn',
        'Token expires_in exceeds 1 year; refusing as malformed.',
      );
    }
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  /// Safe toString — masks access and refresh tokens.
  @override
  String toString() =>
      'Token(scope: $scope, tokenType: $tokenType, expiresIn: $expiresIn, accessToken: [redacted], refreshToken: [redacted])';
}
