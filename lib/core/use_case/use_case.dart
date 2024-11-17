abstract class UseCase<T, P> {}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

mixin _UseCaseCallWithoutParametersMixin<T> on UseCase<T, void> {
  T call();
}

abstract class UseCaseWithoutParameters<T> extends UseCase<T, void>
    with _UseCaseCallWithoutParametersMixin<T> {}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
mixin _UseCaseCallWithoutResultMixin<P> on UseCase<void, P> {
  void call(P param);
}

abstract class UseCaseWithoutResult<P> extends UseCase<void, P>
    with _UseCaseCallWithoutResultMixin<P> {}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
mixin _UseCaseFutureCallNoParamsNoResultMixin on UseCase<void, void> {
  Future<void> call();
}

abstract class UseCaseSimpleFuture extends UseCase<void, void>
    with _UseCaseFutureCallNoParamsNoResultMixin {}
