import '../../domain/interfaces/i_local_cache.dart';
import '../../domain/models/tokens_pair.dart';

class LocalCache implements ILocalCache {
  // ---------------------------------------------------------------------------
  // Read tokens from cache
  @override
  Future<TokensPair?> getAuthTokens() {
    // TODO: implement getAuthTokens
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  // Save new tokens to cache
  @override
  Future<void> setAuthTokens({required TokensPair tokens}) {
    // TODO: implement setAuthTokens
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  // Delete auth tokens
  @override
  Future<void> deleteAuthTokens() async {
    // TODO: implement deleteAuthTokens
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  // Check - is first app start?
  @override
  Future<bool> isFirstAppStart() async {
    // TODO: implement deleteAuthTokens
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  // Get saved locale name
  @override
  Future<String?> getSavedLocale() async {
    // TODO: implement getSavedLocale
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  // Get saved locale name
  @override
  Future<void> setSelectedLocale({required String localeName}) async {
    // TODO: implement setSelectedLocale
    throw UnimplementedError();
  }
}
