import '../../data/api/api_facade.dart';
import '../../data/local_cache/local_cache.dart';
import '../interfaces/i_api_facade.dart';
import '../interfaces/i_authenticate_controller.dart';
import '../interfaces/i_local_cache.dart';
import '../repositories/authenticate_controller.dart';
import 'builders.dep_gen.dart';

class Environment extends DepGenEnvironment {
  Future<Environment> prepare() async {
    final ILocalCache localCache = LocalCache();
    registry<ILocalCache>(localCache);

    final IAuthenticateController authenticateController =
        AuthenticateController(localCache: localCache);
    registry<IAuthenticateController>(authenticateController);

    // -------------------------------------------------------------------------
    // http клиент
    final IApiFacade api = ApiFacade()
      ..setAuthenticateController(authenticateController);
    registry<IApiFacade>(api);

    return this;
  }
}
