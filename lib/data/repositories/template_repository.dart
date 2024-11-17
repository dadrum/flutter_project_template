import 'dart:async';

import '../../domain/repositories/i_template_repository.dart';
import '../interfaces/i_api_facade.dart';

class TemplateRepository implements ITemplateRepository {
  TemplateRepository({
    required IApiFacade api,
  }) : _api = api {
    _templateStreamController =
        StreamController<TemplateRepositoryEvents>.broadcast();
  }

  // ---------------------------------------------------------------------------
  // DEPENDENCIES
  // ignore: unused_field
  final IApiFacade _api;

  // ---------------------------------------------------------------------------
  // STATE
  // -

  // ---------------------------------------------------------------------------
  // SUBSCRIPTIONS / STREAMS
  late final StreamController<TemplateRepositoryEvents>
      _templateStreamController;

  // ---------------------------------------------------------------------------
  // subscribing to events in the repository
  @override
  TemplateRepositorySubscription subscribe(
    Function(TemplateRepositoryEvents) listener, [
    Function(Object error)? onError,
  ]) =>
      _templateStreamController.stream.listen(listener, onError: onError);

  // ---------------------------------------------------------------------------
  // closing the repository
  @override
  Future<void> close() async {
    await _templateStreamController.close();
  }

  // ---------------------------------------------------------------------------
  // Getting some data
  @override
  Future<Object> getSomeData() async {
    return Object();
  }
}
