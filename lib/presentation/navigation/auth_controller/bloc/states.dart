part of 'auth_controller_bloc.dart';

@freezed
class AuthControllerStates with _$AuthControllerStates {
  // splash not initialized yet
  const factory AuthControllerStates.newStatus(
      {required AuthenticateStatus status}) = _StateNewStatus;
}
