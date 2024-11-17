import 'package:dep_gen/dep_gen.dart';

import '../../../core/use_case/use_case.dart';
import '../../../data/interfaces/i_api_facade.dart';
import '../../repositories/i_authenticate_repository.dart';

@DepGen()
final class SetTokensUseCase extends UseCase<Future<void>, dynamic>
    with SetTokensUseCaseMixin<String, String> {
  SetTokensUseCase({
    @DepArg() required IApiFacade apiFacade,
    @DepArg() required IAuthenticateRepository authenticateRepository,
  })  : _apiFacade = apiFacade,
        _authenticateRepository = authenticateRepository;

  final IApiFacade _apiFacade;
  final IAuthenticateRepository _authenticateRepository;

  @override
  Future<void> call({
    required String accessToken,
    required String refreshToken,
  }) async {
    // cache new tokens
    await _authenticateRepository.controller
        .onAuthenticated(accessToken, refreshToken);

    // update http-client
    await _apiFacade.setTokens(accessToken, refreshToken);
  }
}

mixin SetTokensUseCaseMixin<P1, P2> {
  Future<void> call({
    required P1 accessToken,
    required P2 refreshToken,
  });
}
