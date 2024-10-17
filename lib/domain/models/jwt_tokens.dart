import 'package:flutter/foundation.dart';

@immutable
class JwtTokens {
  const JwtTokens({
    required this.access,
    required this.refresh,
  });

  final String access;
  final String refresh;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JwtTokens &&
        other.access == access &&
        other.refresh == refresh;
  }

  @override
  int get hashCode => access.hashCode ^ refresh.hashCode;
}
