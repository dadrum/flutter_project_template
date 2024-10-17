import 'package:flutter/foundation.dart';

@immutable
class JwtTokens {
  const JwtTokens({
    required this.access,
    required this.refresh,
  });

  final String access;
  final String refresh;
}
