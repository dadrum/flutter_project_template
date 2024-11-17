import 'package:dep_gen/dep_gen.dart';

import '../../../core/use_case/use_case.dart';
import '../../../data/interfaces/i_local_cache.dart';

@DepGen()
final class IsFirstAppStartUseCase
    extends UseCaseWithoutParameters<Future<bool>> {
  IsFirstAppStartUseCase({
    @DepArg() required ILocalCache localCache,
  }) : _localCache = localCache;
  final ILocalCache _localCache;

  @override
  Future<bool> call() async {
    return _localCache.isFirstAppStart();
  }
}
