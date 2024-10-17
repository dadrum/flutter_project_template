// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_controller_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    TResult? Function()? onInitializeRequested,
    TResult? Function(AuthenticateStatus newStatus)? onStatusChanged,
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
    TResult? Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult? Function(_EventOnStatusChanged value)? onStatusChanged,
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
      _$AuthControllerEventsCopyWithImpl<$Res, AuthControllerEvents>;
}

/// @nodoc
class _$AuthControllerEventsCopyWithImpl<$Res,
        $Val extends AuthControllerEvents>
    implements $AuthControllerEventsCopyWith<$Res> {
  _$AuthControllerEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthControllerEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EventOnInitialiseRequestedImplCopyWith<$Res> {
  factory _$$EventOnInitialiseRequestedImplCopyWith(
          _$EventOnInitialiseRequestedImpl value,
          $Res Function(_$EventOnInitialiseRequestedImpl) then) =
      __$$EventOnInitialiseRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventOnInitialiseRequestedImplCopyWithImpl<$Res>
    extends _$AuthControllerEventsCopyWithImpl<$Res,
        _$EventOnInitialiseRequestedImpl>
    implements _$$EventOnInitialiseRequestedImplCopyWith<$Res> {
  __$$EventOnInitialiseRequestedImplCopyWithImpl(
      _$EventOnInitialiseRequestedImpl _value,
      $Res Function(_$EventOnInitialiseRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthControllerEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventOnInitialiseRequestedImpl implements _EventOnInitialiseRequested {
  const _$EventOnInitialiseRequestedImpl();

  @override
  String toString() {
    return 'AuthControllerEvents.onInitializeRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventOnInitialiseRequestedImpl);
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
    TResult? Function()? onInitializeRequested,
    TResult? Function(AuthenticateStatus newStatus)? onStatusChanged,
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
    TResult? Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult? Function(_EventOnStatusChanged value)? onStatusChanged,
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
  const factory _EventOnInitialiseRequested() =
      _$EventOnInitialiseRequestedImpl;
}

/// @nodoc
abstract class _$$EventOnStatusChangedImplCopyWith<$Res> {
  factory _$$EventOnStatusChangedImplCopyWith(_$EventOnStatusChangedImpl value,
          $Res Function(_$EventOnStatusChangedImpl) then) =
      __$$EventOnStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthenticateStatus newStatus});
}

/// @nodoc
class __$$EventOnStatusChangedImplCopyWithImpl<$Res>
    extends _$AuthControllerEventsCopyWithImpl<$Res, _$EventOnStatusChangedImpl>
    implements _$$EventOnStatusChangedImplCopyWith<$Res> {
  __$$EventOnStatusChangedImplCopyWithImpl(_$EventOnStatusChangedImpl _value,
      $Res Function(_$EventOnStatusChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthControllerEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStatus = null,
  }) {
    return _then(_$EventOnStatusChangedImpl(
      newStatus: null == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as AuthenticateStatus,
    ));
  }
}

/// @nodoc

class _$EventOnStatusChangedImpl implements _EventOnStatusChanged {
  const _$EventOnStatusChangedImpl({required this.newStatus});

  @override
  final AuthenticateStatus newStatus;

  @override
  String toString() {
    return 'AuthControllerEvents.onStatusChanged(newStatus: $newStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventOnStatusChangedImpl &&
            (identical(other.newStatus, newStatus) ||
                other.newStatus == newStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newStatus);

  /// Create a copy of AuthControllerEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventOnStatusChangedImplCopyWith<_$EventOnStatusChangedImpl>
      get copyWith =>
          __$$EventOnStatusChangedImplCopyWithImpl<_$EventOnStatusChangedImpl>(
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
    TResult? Function()? onInitializeRequested,
    TResult? Function(AuthenticateStatus newStatus)? onStatusChanged,
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
    TResult? Function(_EventOnInitialiseRequested value)? onInitializeRequested,
    TResult? Function(_EventOnStatusChanged value)? onStatusChanged,
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
          {required final AuthenticateStatus newStatus}) =
      _$EventOnStatusChangedImpl;

  AuthenticateStatus get newStatus;

  /// Create a copy of AuthControllerEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventOnStatusChangedImplCopyWith<_$EventOnStatusChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    TResult? Function(AuthenticateStatus status)? newStatus,
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
    TResult? Function(_StateNewStatus value)? newStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNewStatus value)? newStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthControllerStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthControllerStatesCopyWith<AuthControllerStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthControllerStatesCopyWith<$Res> {
  factory $AuthControllerStatesCopyWith(AuthControllerStates value,
          $Res Function(AuthControllerStates) then) =
      _$AuthControllerStatesCopyWithImpl<$Res, AuthControllerStates>;
  @useResult
  $Res call({AuthenticateStatus status});
}

/// @nodoc
class _$AuthControllerStatesCopyWithImpl<$Res,
        $Val extends AuthControllerStates>
    implements $AuthControllerStatesCopyWith<$Res> {
  _$AuthControllerStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthControllerStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticateStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateNewStatusImplCopyWith<$Res>
    implements $AuthControllerStatesCopyWith<$Res> {
  factory _$$StateNewStatusImplCopyWith(_$StateNewStatusImpl value,
          $Res Function(_$StateNewStatusImpl) then) =
      __$$StateNewStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthenticateStatus status});
}

/// @nodoc
class __$$StateNewStatusImplCopyWithImpl<$Res>
    extends _$AuthControllerStatesCopyWithImpl<$Res, _$StateNewStatusImpl>
    implements _$$StateNewStatusImplCopyWith<$Res> {
  __$$StateNewStatusImplCopyWithImpl(
      _$StateNewStatusImpl _value, $Res Function(_$StateNewStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthControllerStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$StateNewStatusImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticateStatus,
    ));
  }
}

/// @nodoc

class _$StateNewStatusImpl implements _StateNewStatus {
  const _$StateNewStatusImpl({required this.status});

  @override
  final AuthenticateStatus status;

  @override
  String toString() {
    return 'AuthControllerStates.newStatus(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateNewStatusImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of AuthControllerStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateNewStatusImplCopyWith<_$StateNewStatusImpl> get copyWith =>
      __$$StateNewStatusImplCopyWithImpl<_$StateNewStatusImpl>(
          this, _$identity);

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
    TResult? Function(AuthenticateStatus status)? newStatus,
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
    TResult? Function(_StateNewStatus value)? newStatus,
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
      _$StateNewStatusImpl;

  @override
  AuthenticateStatus get status;

  /// Create a copy of AuthControllerStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateNewStatusImplCopyWith<_$StateNewStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
