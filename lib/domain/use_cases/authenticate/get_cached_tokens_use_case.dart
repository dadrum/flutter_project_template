import 'package:dep_gen/dep_gen.dart';

import '../../../core/use_case/use_case.dart';
import '../../../data/interfaces/i_local_cache.dart';
import '../../entities/jwt_tokens.dart';

@DepGen()
final class GetCachedTokensUseCase
    extends UseCaseWithoutParameters<Future<JwtTokens?>> {
  GetCachedTokensUseCase({
    @DepArg() required ILocalCache localCache,
  }) : _localCache = localCache;
  final ILocalCache _localCache;

  @override
  Future<JwtTokens?> call() async {
    return _localCache.getAuthTokens();
  }
}
