import 'package:flutter/foundation.dart';

@immutable
class TokensPair {
  final String accessToken;
  final String refreshToken;

  TokensPair({
    required this.accessToken,
    required this.refreshToken,
  });
}
