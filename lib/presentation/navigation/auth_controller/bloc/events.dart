part of 'auth_controller_bloc.dart';

@freezed
class AuthControllerEvents with _$AuthControllerEvents {
  const factory AuthControllerEvents.onInitializeRequested() =
      _EventOnInitialiseRequested;

  const factory AuthControllerEvents.onStatusChanged(
      {required AuthenticateStatus newStatus}) = _EventOnStatusChanged;
}
