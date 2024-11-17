import 'package:dep_gen/dep_gen.dart';

import '../../../core/use_case/use_case.dart';
import '../../../data/interfaces/i_api_facade.dart';
import '../../entities/jwt_tokens.dart';

typedef _AliasReturn = Future<JwtTokens>;
typedef _AliasParameter = String;

@DepGen()
final class RefreshTokensUseCase extends UseCase<_AliasReturn, _AliasParameter>
    with RefreshTokensUseCaseMixin<_AliasReturn, _AliasParameter> {
  RefreshTokensUseCase({
    @DepArg() required IApiFacade apiFacade,
  }) : _apiFacade = apiFacade;

  final IApiFacade _apiFacade;

  @override
  _AliasReturn call({
    required _AliasParameter refreshToken,
  }) async {
    return _apiFacade.refreshTokens(refreshToken: refreshToken);
  }
}

mixin RefreshTokensUseCaseMixin<T, P>
    on UseCase<_AliasReturn, _AliasParameter> {
  _AliasReturn call({
    required _AliasParameter refreshToken,
  });
}
