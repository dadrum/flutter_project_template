import '../models/tokens_pair.dart';

abstract class ILocalCache {
  // Methods
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // Read tokens from cache
  Future<TokensPair?> getAuthTokens();

  // ---------------------------------------------------------------------------
  // Save new tokens to cache
  Future<void> setAuthTokens({required TokensPair tokens});

  // ---------------------------------------------------------------------------
  // Delete auth tokens
  Future<void> deleteAuthTokens();

  // ---------------------------------------------------------------------------
  // Check - is first app start?
  Future<bool> isFirstAppStart();

  // ---------------------------------------------------------------------------
  // Get saved locale name
  Future<String?> getSavedLocale();

  // ---------------------------------------------------------------------------
  // Get saved locale name
  Future<void> setSelectedLocale({required String localeName});
}
