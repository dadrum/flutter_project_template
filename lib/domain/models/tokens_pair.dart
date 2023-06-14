import 'package:flutter/foundation.dart';

@immutable
class TokensPair {
  const TokensPair({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;
}
