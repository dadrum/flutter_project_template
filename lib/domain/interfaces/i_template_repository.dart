import 'dart:async';

// -----------------------------------------------------------------------------
/// events in the repository
sealed class TemplateRepositoryEvents {}

// some event
final class TemplateRepositoryOnSomeEvent implements TemplateRepositoryEvents {}

// -----------------------------------------------------------------------------
/// repository subscription type
typedef TemplateRepositorySubscription
    = StreamSubscription<TemplateRepositoryEvents>;

// -----------------------------------------------------------------------------
abstract class ITemplateRepository {
  /// subscribing to events in the repository
  TemplateRepositorySubscription subscribe(
    Function(TemplateRepositoryEvents) listener, [
    Function(Object error)? onError,
  ]);

  /// closing the repository
  Future<void> close();

  /// Getting some data
  Future<Object> getSomeData();
}
