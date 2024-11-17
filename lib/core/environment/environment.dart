import '../../data/api/api_facade.dart';
import '../../data/interfaces/i_api_facade.dart';
import '../../data/interfaces/i_local_cache.dart';
import '../../data/local_cache/local_cache.dart';
import '../../data/repositories/authenticate_repository.dart';
import '../../data/repositories/template_repository.dart';
import '../../domain/repositories/i_authenticate_repository.dart';
import '../../domain/repositories/i_template_repository.dart';
import '../../domain/use_cases/authenticate/delete_auth_tokens_use_case.dart';
import '../../domain/use_cases/authenticate/get_cached_tokens_use_case.dart';
import '../../domain/use_cases/authenticate/refresh_tokens_use_case.dart';
import '../../domain/use_cases/authenticate/set_tokens_use_case.dart';
import '../../domain/use_cases/local_cache/is_first_app_start_use_case.dart';
import 'builders.dep_gen.dart';

class Environment extends DepGenEnvironment {
  Future<Environment> prepare() async {
    // -------------------------------------------------------------------------
    // #DATA_PROVIDER
    registry<ILocalCache>(LocalCache());

    // -------------------------------------------------------------------------
    // #DATA_REPOSITORY
    registry<IAuthenticateRepository>(
      AuthenticateRepository(
        localCache: g<ILocalCache>(),
      ),
    );

    // -------------------------------------------------------------------------
    // #DATA_PROVIDER
    final IApiFacade api = ApiFacade()
      ..setAuthenticateController(
        g<IAuthenticateRepository>().controller,
      );
    registry<IApiFacade>(api);

    // -------------------------------------------------------------------------
    // #DATA_REPOSITORY
    registry<ITemplateRepository>(TemplateRepository(api: api));

    return this;
  }

  // ---------------------------------------------------------------------------
  void registryUseCases(DepProvider provider) {
    registry<GetCachedTokensUseCase>(
      provider.buildGetCachedTokensUseCase(),
    );
    registry<IsFirstAppStartUseCase>(
      provider.buildIsFirstAppStartUseCase(),
    );
    registry<RefreshTokensUseCase>(
      provider.buildRefreshTokensUseCase(),
    );
    registry<DeleteAuthTokensUseCase>(
      provider.buildDeleteAuthTokensUseCase(),
    );
    registry<SetTokensUseCase>(
      provider.buildSetTokensUseCase(),
    );
  }
}
