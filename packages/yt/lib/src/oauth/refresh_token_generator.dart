import 'package:yt/yt.dart';

abstract class RefreshTokenGenerator {
  Future<Token> generate();
}
