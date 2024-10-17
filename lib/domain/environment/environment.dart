import '../../data/api/api_facade.dart';
import '../../data/local_cache/local_cache.dart';
import '../interfaces/i_api_facade.dart';
import '../interfaces/i_authenticate_repository.dart';
import '../interfaces/i_local_cache.dart';
import '../repositories/authenticate_repository.dart';
import 'builders.dep_gen.dart';

class Environment extends DepGenEnvironment {
  Future<Environment> prepare() async {
    // -------------------------------------------------------------------------
    // #DATA: local cache
    final ILocalCache localCache = LocalCache();
    registry<ILocalCache>(localCache);

    // -------------------------------------------------------------------------
    // #DOMAIN: Authentication Repository
    final IAuthenticateRepository authenticateRepository =
        AuthenticateRepository(localCache: localCache);
    registry<IAuthenticateRepository>(authenticateRepository);

    // -------------------------------------------------------------------------
    // #DATA: http client
    final IApiFacade api = ApiFacade()
      ..setAuthenticateController(authenticateRepository.controller);
    registry<IApiFacade>(api);

    return this;
  }
}
