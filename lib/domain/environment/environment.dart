import '../../data/api/api_facade.dart';
import '../../data/local_cache/local_cache.dart';
import '../interfaces/i_api_facade.dart';
import '../interfaces/i_authenticate_controller.dart';
import '../interfaces/i_local_cache.dart';
import '../repositories/authenticate_controller.dart';

class Environment {
  static Future<Map<Type, Object>> buildEnvironment(
      {Map<Type, Object>? initialMap}) async {
    final Map<Type, Object> ret = initialMap ?? {};
    // -------------------------------------------------------------------------
    // Local cache
    final ILocalCache localCache = LocalCache();
    ret[ILocalCache] = localCache;

    // -------------------------------------------------------------------------
    // Authenticate controller
    final IAuthenticateController authenticateController =
        AuthenticateController(localCache: localCache);
    ret[IAuthenticateController] = authenticateController;

    // -------------------------------------------------------------------------
    // http клиент
    final IApiFacade api = ApiFacade()
      ..setAuthenticateController(authenticateController);
    ret[IApiFacade] = api;

    return ret;
  }
}
