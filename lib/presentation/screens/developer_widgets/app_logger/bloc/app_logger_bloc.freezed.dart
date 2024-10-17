// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_logger_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppLoggerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onUpdateRequested,
    required TResult Function() onClearRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onUpdateRequested,
    TResult? Function()? onClearRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onUpdateRequested,
    TResult Function()? onClearRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventOnUpdateRequested value) onUpdateRequested,
    required TResult Function(_EventOnClearRequested value) onClearRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EventOnUpdateRequested value)? onUpdateRequested,
    TResult? Function(_EventOnClearRequested value)? onClearRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventOnUpdateRequested value)? onUpdateRequested,
    TResult Function(_EventOnClearRequested value)? onClearRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppLoggerEventCopyWith<$Res> {
  factory $AppLoggerEventCopyWith(
          AppLoggerEvent value, $Res Function(AppLoggerEvent) then) =
      _$AppLoggerEventCopyWithImpl<$Res, AppLoggerEvent>;
}

/// @nodoc
class _$AppLoggerEventCopyWithImpl<$Res, $Val extends AppLoggerEvent>
    implements $AppLoggerEventCopyWith<$Res> {
  _$AppLoggerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppLoggerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EventOnUpdateRequestedImplCopyWith<$Res> {
  factory _$$EventOnUpdateRequestedImplCopyWith(
          _$EventOnUpdateRequestedImpl value,
          $Res Function(_$EventOnUpdateRequestedImpl) then) =
      __$$EventOnUpdateRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventOnUpdateRequestedImplCopyWithImpl<$Res>
    extends _$AppLoggerEventCopyWithImpl<$Res, _$EventOnUpdateRequestedImpl>
    implements _$$EventOnUpdateRequestedImplCopyWith<$Res> {
  __$$EventOnUpdateRequestedImplCopyWithImpl(
      _$EventOnUpdateRequestedImpl _value,
      $Res Function(_$EventOnUpdateRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppLoggerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventOnUpdateRequestedImpl implements _EventOnUpdateRequested {
  const _$EventOnUpdateRequestedImpl();

  @override
  String toString() {
    return 'AppLoggerEvent.onUpdateRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventOnUpdateRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onUpdateRequested,
    required TResult Function() onClearRequested,
  }) {
    return onUpdateRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onUpdateRequested,
    TResult? Function()? onClearRequested,
  }) {
    return onUpdateRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onUpdateRequested,
    TResult Function()? onClearRequested,
    required TResult orElse(),
  }) {
    if (onUpdateRequested != null) {
      return onUpdateRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventOnUpdateRequested value) onUpdateRequested,
    required TResult Function(_EventOnClearRequested value) onClearRequested,
  }) {
    return onUpdateRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EventOnUpdateRequested value)? onUpdateRequested,
    TResult? Function(_EventOnClearRequested value)? onClearRequested,
  }) {
    return onUpdateRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventOnUpdateRequested value)? onUpdateRequested,
    TResult Function(_EventOnClearRequested value)? onClearRequested,
    required TResult orElse(),
  }) {
    if (onUpdateRequested != null) {
      return onUpdateRequested(this);
    }
    return orElse();
  }
}

abstract class _EventOnUpdateRequested implements AppLoggerEvent {
  const factory _EventOnUpdateRequested() = _$EventOnUpdateRequestedImpl;
}

/// @nodoc
abstract class _$$EventOnClearRequestedImplCopyWith<$Res> {
  factory _$$EventOnClearRequestedImplCopyWith(
          _$EventOnClearRequestedImpl value,
          $Res Function(_$EventOnClearRequestedImpl) then) =
      __$$EventOnClearRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventOnClearRequestedImplCopyWithImpl<$Res>
    extends _$AppLoggerEventCopyWithImpl<$Res, _$EventOnClearRequestedImpl>
    implements _$$EventOnClearRequestedImplCopyWith<$Res> {
  __$$EventOnClearRequestedImplCopyWithImpl(_$EventOnClearRequestedImpl _value,
      $Res Function(_$EventOnClearRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppLoggerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventOnClearRequestedImpl implements _EventOnClearRequested {
  const _$EventOnClearRequestedImpl();

  @override
  String toString() {
    return 'AppLoggerEvent.onClearRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventOnClearRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onUpdateRequested,
    required TResult Function() onClearRequested,
  }) {
    return onClearRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onUpdateRequested,
    TResult? Function()? onClearRequested,
  }) {
    return onClearRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onUpdateRequested,
    TResult Function()? onClearRequested,
    required TResult orElse(),
  }) {
    if (onClearRequested != null) {
      return onClearRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventOnUpdateRequested value) onUpdateRequested,
    required TResult Function(_EventOnClearRequested value) onClearRequested,
  }) {
    return onClearRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EventOnUpdateRequested value)? onUpdateRequested,
    TResult? Function(_EventOnClearRequested value)? onClearRequested,
  }) {
    return onClearRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventOnUpdateRequested value)? onUpdateRequested,
    TResult Function(_EventOnClearRequested value)? onClearRequested,
    required TResult orElse(),
  }) {
    if (onClearRequested != null) {
      return onClearRequested(this);
    }
    return orElse();
  }
}

abstract class _EventOnClearRequested implements AppLoggerEvent {
  const factory _EventOnClearRequested() = _$EventOnClearRequestedImpl;
}

/// @nodoc
mixin _$AppLoggerState {
  Iterable<String> get logsStack => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<String> logsStack) screenState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<String> logsStack)? screenState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<String> logsStack)? screenState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScreenState value) screenState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScreenState value)? screenState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScreenState value)? screenState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AppLoggerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppLoggerStateCopyWith<AppLoggerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppLoggerStateCopyWith<$Res> {
  factory $AppLoggerStateCopyWith(
          AppLoggerState value, $Res Function(AppLoggerState) then) =
      _$AppLoggerStateCopyWithImpl<$Res, AppLoggerState>;
  @useResult
  $Res call({Iterable<String> logsStack});
}

/// @nodoc
class _$AppLoggerStateCopyWithImpl<$Res, $Val extends AppLoggerState>
    implements $AppLoggerStateCopyWith<$Res> {
  _$AppLoggerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppLoggerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logsStack = null,
  }) {
    return _then(_value.copyWith(
      logsStack: null == logsStack
          ? _value.logsStack
          : logsStack // ignore: cast_nullable_to_non_nullable
              as Iterable<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenStateImplCopyWith<$Res>
    implements $AppLoggerStateCopyWith<$Res> {
  factory _$$ScreenStateImplCopyWith(
          _$ScreenStateImpl value, $Res Function(_$ScreenStateImpl) then) =
      __$$ScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Iterable<String> logsStack});
}

/// @nodoc
class __$$ScreenStateImplCopyWithImpl<$Res>
    extends _$AppLoggerStateCopyWithImpl<$Res, _$ScreenStateImpl>
    implements _$$ScreenStateImplCopyWith<$Res> {
  __$$ScreenStateImplCopyWithImpl(
      _$ScreenStateImpl _value, $Res Function(_$ScreenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppLoggerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logsStack = null,
  }) {
    return _then(_$ScreenStateImpl(
      logsStack: null == logsStack
          ? _value.logsStack
          : logsStack // ignore: cast_nullable_to_non_nullable
              as Iterable<String>,
    ));
  }
}

/// @nodoc

class _$ScreenStateImpl implements _ScreenState {
  const _$ScreenStateImpl({required this.logsStack});

  @override
  final Iterable<String> logsStack;

  @override
  String toString() {
    return 'AppLoggerState.screenState(logsStack: $logsStack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenStateImpl &&
            const DeepCollectionEquality().equals(other.logsStack, logsStack));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(logsStack));

  /// Create a copy of AppLoggerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenStateImplCopyWith<_$ScreenStateImpl> get copyWith =>
      __$$ScreenStateImplCopyWithImpl<_$ScreenStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<String> logsStack) screenState,
  }) {
    return screenState(logsStack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<String> logsStack)? screenState,
  }) {
    return screenState?.call(logsStack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<String> logsStack)? screenState,
    required TResult orElse(),
  }) {
    if (screenState != null) {
      return screenState(logsStack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ScreenState value) screenState,
  }) {
    return screenState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ScreenState value)? screenState,
  }) {
    return screenState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ScreenState value)? screenState,
    required TResult orElse(),
  }) {
    if (screenState != null) {
      return screenState(this);
    }
    return orElse();
  }
}

abstract class _ScreenState implements AppLoggerState {
  const factory _ScreenState({required final Iterable<String> logsStack}) =
      _$ScreenStateImpl;

  @override
  Iterable<String> get logsStack;

  /// Create a copy of AppLoggerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScreenStateImplCopyWith<_$ScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
