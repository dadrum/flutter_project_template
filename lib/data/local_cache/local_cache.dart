import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/extensions/iterable_extensions.dart';
import '../../domain/interfaces/i_local_cache.dart';
import '../../domain/models/in_app_timer.dart';
import '../../domain/models/jwt_tokens.dart';
import '../../domain/models/theme_type.dart';

class LocalCache extends ChangeNotifier implements ILocalCache {
  final secureStorage = const FlutterSecureStorage();
  static const tokensPairKey = 'tokens';

  /// Is this the first launch of the app?
  static const firstStartKey = 'firstStart';

  /// saving the type of the design theme
  static const themeKey = 'themeType';

  // ---------------------------------------------------------------------------
  // adding a change listener
  @override
  void addChangeListener(VoidCallback listener) {
    addListener(listener);
  }

  // ---------------------------------------------------------------------------
  // deleting a change listener
  @override
  void removeChangeListener(VoidCallback listener) {
    removeListener(listener);
  }

  // ---------------------------------------------------------------------------
  // Read tokens from cache
  @override
  Future<JwtTokens?> getAuthTokens() async {
    try {
      final String? tokenJson = await secureStorage.read(key: tokensPairKey);
      return tokenJson != null ? _tokensFromJson(tokenJson) : null;
    } on PlatformException {
      await secureStorage.deleteAll();
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Save new tokens to cache
  @override
  Future<void> setAuthTokens({required JwtTokens tokens}) async {
    await secureStorage.write(
        key: tokensPairKey,
        value: _tokensToJson(tokens.access, tokens.refresh));
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Delete auth tokens
  @override
  Future<void> deleteAuthTokens() async {
    await secureStorage.delete(key: tokensPairKey);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  String _tokensToJson(String accessToken, String refreshToken) {
    return jsonEncode(
        {'accessToken': accessToken, 'refreshToken': refreshToken});
  }

  // ---------------------------------------------------------------------------
  JwtTokens _tokensFromJson(String json) {
    final jsonObject = jsonDecode(json) as Map<String, dynamic>;
    return JwtTokens(
        access: '${jsonObject['accessToken']}',
        refresh: '${jsonObject['refreshToken']}');
  }

  // ---------------------------------------------------------------------------
  // setting the timer end time
  @override
  Future<void> saveTimerEndTime(InAppTimers timerType, DateTime endTime) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final timerKey = _getTimerKey(timerType);
    await sharedPreferences.setInt(timerKey, endTime.millisecondsSinceEpoch);
    await sharedPreferences.reload();
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // deleting the timer end time
  @override
  Future<void> deleteTimerEndTime(InAppTimers timerType) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final timerKey = _getTimerKey(timerType);
    await sharedPreferences.remove(timerKey);
    await sharedPreferences.reload();
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // getting the timer end time
  @override
  Future<DateTime?> getTimerEndTime(InAppTimers timerType) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final timerKey = _getTimerKey(timerType);

    final millisecondsSinceEpoch = sharedPreferences.getInt(timerKey);

    if (millisecondsSinceEpoch == null) {
      return null;
    } else {
      return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    }
  }

  // ---------------------------------------------------------------------------
  String _getTimerKey(InAppTimers timerType) => 'keyTimers' + timerType.name;

  // ---------------------------------------------------------------------------
  // saving the type of the design theme
  @override
  Future<void> saveThemeType(ThemeTypes type) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(themeKey, type.name);
    await sharedPreferences.reload();
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // reading the type of the design theme
  @override
  Future<ThemeTypes?> getThemeType() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final cachedValue = sharedPreferences.getString(themeKey);
    return ThemeTypes.values.firstWhereOrNull((e) => e.name == cachedValue);
  }

  // ---------------------------------------------------------------------------
  // the sign of the first launch of the application
  @override
  Future<bool> isFirstAppStart() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final cachedValue = sharedPreferences.getBool(firstStartKey);
    return cachedValue == null;
  }

  // ---------------------------------------------------------------------------
  // setting the sign of the first launch of the application
  @override
  Future<void> setFirstAppStart() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool(firstStartKey, true);
    await sharedPreferences.reload();
    notifyListeners();
  }
}
