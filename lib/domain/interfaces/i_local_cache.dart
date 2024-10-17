import 'package:flutter/foundation.dart';

import '../models/in_app_timer.dart';
import '../models/jwt_tokens.dart';
import '../models/theme_type.dart';

abstract class ILocalCache {
  // Methods
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// adding a change listener
  void addChangeListener(VoidCallback listener);

  // ---------------------------------------------------------------------------
  /// deleting a change listener
  void removeChangeListener(VoidCallback listener);

  // ---------------------------------------------------------------------------
  /// Read tokens from cache
  Future<JwtTokens?> getAuthTokens();

  // ---------------------------------------------------------------------------
  /// Save new tokens to cache
  Future<void> setAuthTokens({required JwtTokens tokens});

  // ---------------------------------------------------------------------------
  /// Delete auth tokens
  Future<void> deleteAuthTokens();

  // ---------------------------------------------------------------------------
  /// setting the timer end time
  Future<void> saveTimerEndTime(InAppTimers timerType, DateTime endTime);

  /// getting the timer end time
  Future<DateTime?> getTimerEndTime(InAppTimers timerType);

  /// deleting the timer end time
  Future<void> deleteTimerEndTime(InAppTimers timerType);

  // ---------------------------------------------------------------------------
  /// saving the type of the design theme
  Future<void> saveThemeType(ThemeTypes type);

  /// reading the type of the design theme
  Future<ThemeTypes?> getThemeType();

  // ---------------------------------------------------------------------------
  /// the sign of the first launch of the application
  Future<bool> isFirstAppStart();

  /// setting the sign of the first launch of the application
  Future<void> setFirstAppStart();
}
