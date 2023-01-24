// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_controller_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthControllerEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onInitializeRequested,
    required TResult Function(AuthenticateStatus newStatus) onStatusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? onInitializeRequested,
    TResult Function(AuthenticateStatus newStatus)? onStatusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onInitializeRequested,
    TResult Function(AuthenticateStatus newStatus)? onStatusChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventOnInitialiseRequested value)
        onInitializeRequested,
    required TResult Function(_EventOnStatusChanged value) onStatusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult Function(_EventOnStatusChanged value)? onStatusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult Function(_EventOnStatusChanged value)? onStatusChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthControllerEventsCopyWith<$Res> {
  factory $AuthControllerEventsCopyWith(AuthControllerEvents value,
          $Res Function(AuthControllerEvents) then) =
      _$AuthControllerEventsCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthControllerEventsCopyWithImpl<$Res>
    implements $AuthControllerEventsCopyWith<$Res> {
  _$AuthControllerEventsCopyWithImpl(this._value, this._then);

  final AuthControllerEvents _value;
  // ignore: unused_field
  final $Res Function(AuthControllerEvents) _then;
}

/// @nodoc
abstract class _$$_EventOnInitialiseRequestedCopyWith<$Res> {
  factory _$$_EventOnInitialiseRequestedCopyWith(
          _$_EventOnInitialiseRequested value,
          $Res Function(_$_EventOnInitialiseRequested) then) =
      __$$_EventOnInitialiseRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_EventOnInitialiseRequestedCopyWithImpl<$Res>
    extends _$AuthControllerEventsCopyWithImpl<$Res>
    implements _$$_EventOnInitialiseRequestedCopyWith<$Res> {
  __$$_EventOnInitialiseRequestedCopyWithImpl(
      _$_EventOnInitialiseRequested _value,
      $Res Function(_$_EventOnInitialiseRequested) _then)
      : super(_value, (v) => _then(v as _$_EventOnInitialiseRequested));

  @override
  _$_EventOnInitialiseRequested get _value =>
      super._value as _$_EventOnInitialiseRequested;
}

/// @nodoc

class _$_EventOnInitialiseRequested implements _EventOnInitialiseRequested {
  const _$_EventOnInitialiseRequested();

  @override
  String toString() {
    return 'AuthControllerEvents.onInitializeRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventOnInitialiseRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onInitializeRequested,
    required TResult Function(AuthenticateStatus newStatus) onStatusChanged,
  }) {
    return onInitializeRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? onInitializeRequested,
    TResult Function(AuthenticateStatus newStatus)? onStatusChanged,
  }) {
    return onInitializeRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onInitializeRequested,
    TResult Function(AuthenticateStatus newStatus)? onStatusChanged,
    required TResult orElse(),
  }) {
    if (onInitializeRequested != null) {
      return onInitializeRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventOnInitialiseRequested value)
        onInitializeRequested,
    required TResult Function(_EventOnStatusChanged value) onStatusChanged,
  }) {
    return onInitializeRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult Function(_EventOnStatusChanged value)? onStatusChanged,
  }) {
    return onInitializeRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult Function(_EventOnStatusChanged value)? onStatusChanged,
    required TResult orElse(),
  }) {
    if (onInitializeRequested != null) {
      return onInitializeRequested(this);
    }
    return orElse();
  }
}

abstract class _EventOnInitialiseRequested implements AuthControllerEvents {
  const factory _EventOnInitialiseRequested() = _$_EventOnInitialiseRequested;
}

/// @nodoc
abstract class _$$_EventOnStatusChangedCopyWith<$Res> {
  factory _$$_EventOnStatusChangedCopyWith(_$_EventOnStatusChanged value,
          $Res Function(_$_EventOnStatusChanged) then) =
      __$$_EventOnStatusChangedCopyWithImpl<$Res>;
  $Res call({AuthenticateStatus newStatus});
}

/// @nodoc
class __$$_EventOnStatusChangedCopyWithImpl<$Res>
    extends _$AuthControllerEventsCopyWithImpl<$Res>
    implements _$$_EventOnStatusChangedCopyWith<$Res> {
  __$$_EventOnStatusChangedCopyWithImpl(_$_EventOnStatusChanged _value,
      $Res Function(_$_EventOnStatusChanged) _then)
      : super(_value, (v) => _then(v as _$_EventOnStatusChanged));

  @override
  _$_EventOnStatusChanged get _value => super._value as _$_EventOnStatusChanged;

  @override
  $Res call({
    Object? newStatus = freezed,
  }) {
    return _then(_$_EventOnStatusChanged(
      newStatus: newStatus == freezed
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as AuthenticateStatus,
    ));
  }
}

/// @nodoc

class _$_EventOnStatusChanged implements _EventOnStatusChanged {
  const _$_EventOnStatusChanged({required this.newStatus});

  @override
  final AuthenticateStatus newStatus;

  @override
  String toString() {
    return 'AuthControllerEvents.onStatusChanged(newStatus: $newStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventOnStatusChanged &&
            const DeepCollectionEquality().equals(other.newStatus, newStatus));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(newStatus));

  @JsonKey(ignore: true)
  @override
  _$$_EventOnStatusChangedCopyWith<_$_EventOnStatusChanged> get copyWith =>
      __$$_EventOnStatusChangedCopyWithImpl<_$_EventOnStatusChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onInitializeRequested,
    required TResult Function(AuthenticateStatus newStatus) onStatusChanged,
  }) {
    return onStatusChanged(newStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? onInitializeRequested,
    TResult Function(AuthenticateStatus newStatus)? onStatusChanged,
  }) {
    return onStatusChanged?.call(newStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onInitializeRequested,
    TResult Function(AuthenticateStatus newStatus)? onStatusChanged,
    required TResult orElse(),
  }) {
    if (onStatusChanged != null) {
      return onStatusChanged(newStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventOnInitialiseRequested value)
        onInitializeRequested,
    required TResult Function(_EventOnStatusChanged value) onStatusChanged,
  }) {
    return onStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult Function(_EventOnStatusChanged value)? onStatusChanged,
  }) {
    return onStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult Function(_EventOnStatusChanged value)? onStatusChanged,
    required TResult orElse(),
  }) {
    if (onStatusChanged != null) {
      return onStatusChanged(this);
    }
    return orElse();
  }
}

abstract class _EventOnStatusChanged implements AuthControllerEvents {
  const factory _EventOnStatusChanged(
      {required final AuthenticateStatus newStatus}) = _$_EventOnStatusChanged;

  AuthenticateStatus get newStatus;
  @JsonKey(ignore: true)
  _$$_EventOnStatusChangedCopyWith<_$_EventOnStatusChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthControllerStates {
  AuthenticateStatus get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticateStatus status) newStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticateStatus status)? newStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticateStatus status)? newStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateNewStatus value) newStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StateNewStatus value)? newStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNewStatus value)? newStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthControllerStatesCopyWith<AuthControllerStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthControllerStatesCopyWith<$Res> {
  factory $AuthControllerStatesCopyWith(AuthControllerStates value,
          $Res Function(AuthControllerStates) then) =
      _$AuthControllerStatesCopyWithImpl<$Res>;
  $Res call({AuthenticateStatus status});
}

/// @nodoc
class _$AuthControllerStatesCopyWithImpl<$Res>
    implements $AuthControllerStatesCopyWith<$Res> {
  _$AuthControllerStatesCopyWithImpl(this._value, this._then);

  final AuthControllerStates _value;
  // ignore: unused_field
  final $Res Function(AuthControllerStates) _then;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticateStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_StateNewStatusCopyWith<$Res>
    implements $AuthControllerStatesCopyWith<$Res> {
  factory _$$_StateNewStatusCopyWith(
          _$_StateNewStatus value, $Res Function(_$_StateNewStatus) then) =
      __$$_StateNewStatusCopyWithImpl<$Res>;
  @override
  $Res call({AuthenticateStatus status});
}

/// @nodoc
class __$$_StateNewStatusCopyWithImpl<$Res>
    extends _$AuthControllerStatesCopyWithImpl<$Res>
    implements _$$_StateNewStatusCopyWith<$Res> {
  __$$_StateNewStatusCopyWithImpl(
      _$_StateNewStatus _value, $Res Function(_$_StateNewStatus) _then)
      : super(_value, (v) => _then(v as _$_StateNewStatus));

  @override
  _$_StateNewStatus get _value => super._value as _$_StateNewStatus;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$_StateNewStatus(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticateStatus,
    ));
  }
}

/// @nodoc

class _$_StateNewStatus implements _StateNewStatus {
  const _$_StateNewStatus({required this.status});

  @override
  final AuthenticateStatus status;

  @override
  String toString() {
    return 'AuthControllerStates.newStatus(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StateNewStatus &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_StateNewStatusCopyWith<_$_StateNewStatus> get copyWith =>
      __$$_StateNewStatusCopyWithImpl<_$_StateNewStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticateStatus status) newStatus,
  }) {
    return newStatus(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticateStatus status)? newStatus,
  }) {
    return newStatus?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticateStatus status)? newStatus,
    required TResult orElse(),
  }) {
    if (newStatus != null) {
      return newStatus(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateNewStatus value) newStatus,
  }) {
    return newStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StateNewStatus value)? newStatus,
  }) {
    return newStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNewStatus value)? newStatus,
    required TResult orElse(),
  }) {
    if (newStatus != null) {
      return newStatus(this);
    }
    return orElse();
  }
}

abstract class _StateNewStatus implements AuthControllerStates {
  const factory _StateNewStatus({required final AuthenticateStatus status}) =
      _$_StateNewStatus;

  @override
  AuthenticateStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_StateNewStatusCopyWith<_$_StateNewStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
