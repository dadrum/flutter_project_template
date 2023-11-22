import 'package:dep_gen/dep_gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/interfaces/i_api_facade.dart';
import '../../../../domain/interfaces/i_authenticate_repository.dart';

part 'events.dart';

part 'auth_controller_bloc.freezed.dart';

part 'states.dart';

@DepGen()
class AuthControllerBloc
    extends Bloc<AuthControllerEvents, AuthControllerStates> {
  // ---------------------------------------------------------------------------
  AuthControllerBloc({
    @DepArg() required this.authenticateRepository,
    @DepArg() required this.api,
  }) : super(AuthControllerStates.newStatus(
            status: authenticateRepository.controller.status)) {
    on<AuthControllerEvents>((event, emitter) => event.map(
          onStatusChanged: (event) => onStatusChanged(event, emitter),
          onInitializeRequested: (event) =>
              onInitializeRequested(event, emitter),
        ));

    add(const AuthControllerEvents.onInitializeRequested());
  }

  // ---------------------------------------------------------------------------
  final IAuthenticateRepository authenticateRepository;
  final IApiFacade api;

  AuthenticateSubscription? _authenticateSubscription;
  // ---------------------------------------------------------------------------
  @override
  Future<void> close() async {
    _authenticateSubscription?.cancel();
    super.close();
  }

  // ---------------------------------------------------------------------------
  Future<void> onAuthStateListener(AuthenticateStatus status) async {
    if (!isClosed) {
      add(AuthControllerEvents.onStatusChanged(newStatus: status));
    }
  }

  // ---------------------------------------------------------------------------
  Future<void> onStatusChanged(_EventOnStatusChanged event,
      Emitter<AuthControllerStates> emitter) async {
    emitter(AuthControllerStates.newStatus(status: event.newStatus));
  }

  // ---------------------------------------------------------------------------
  Future<void> onInitializeRequested(_EventOnInitialiseRequested event,
      Emitter<AuthControllerStates> emitter) async {
    if (_authenticateSubscription != null) {
      return;
    }

    _authenticateSubscription =
        authenticateRepository.subscribe(onAuthStateListener);
  }
}
