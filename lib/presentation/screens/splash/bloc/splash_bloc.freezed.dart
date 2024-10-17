// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SplashEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventInitialize value) initialize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EventInitialize value)? initialize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventInitialize value)? initialize,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashEventsCopyWith<$Res> {
  factory $SplashEventsCopyWith(
          SplashEvents value, $Res Function(SplashEvents) then) =
      _$SplashEventsCopyWithImpl<$Res, SplashEvents>;
}

/// @nodoc
class _$SplashEventsCopyWithImpl<$Res, $Val extends SplashEvents>
    implements $SplashEventsCopyWith<$Res> {
  _$SplashEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SplashEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EventInitializeImplCopyWith<$Res> {
  factory _$$EventInitializeImplCopyWith(_$EventInitializeImpl value,
          $Res Function(_$EventInitializeImpl) then) =
      __$$EventInitializeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventInitializeImplCopyWithImpl<$Res>
    extends _$SplashEventsCopyWithImpl<$Res, _$EventInitializeImpl>
    implements _$$EventInitializeImplCopyWith<$Res> {
  __$$EventInitializeImplCopyWithImpl(
      _$EventInitializeImpl _value, $Res Function(_$EventInitializeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SplashEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventInitializeImpl implements _EventInitialize {
  const _$EventInitializeImpl();

  @override
  String toString() {
    return 'SplashEvents.initialize()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EventInitializeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EventInitialize value) initialize,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EventInitialize value)? initialize,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EventInitialize value)? initialize,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class _EventInitialize implements SplashEvents {
  const factory _EventInitialize() = _$EventInitializeImpl;
}

/// @nodoc
mixin _$SplashStates {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function(bool isFirstStart) initializationCompleted,
    required TResult Function(String locale) initializeLocale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notInitialized,
    TResult? Function(bool isFirstStart)? initializationCompleted,
    TResult? Function(String locale)? initializeLocale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function(bool isFirstStart)? initializationCompleted,
    TResult Function(String locale)? initializeLocale,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateNotInitialized value) notInitialized,
    required TResult Function(_StateInitializationCompleted value)
        initializationCompleted,
    required TResult Function(_StateInitializeLocale value) initializeLocale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateNotInitialized value)? notInitialized,
    TResult? Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult? Function(_StateInitializeLocale value)? initializeLocale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNotInitialized value)? notInitialized,
    TResult Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult Function(_StateInitializeLocale value)? initializeLocale,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashStatesCopyWith<$Res> {
  factory $SplashStatesCopyWith(
          SplashStates value, $Res Function(SplashStates) then) =
      _$SplashStatesCopyWithImpl<$Res, SplashStates>;
}

/// @nodoc
class _$SplashStatesCopyWithImpl<$Res, $Val extends SplashStates>
    implements $SplashStatesCopyWith<$Res> {
  _$SplashStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StateNotInitializedImplCopyWith<$Res> {
  factory _$$StateNotInitializedImplCopyWith(_$StateNotInitializedImpl value,
          $Res Function(_$StateNotInitializedImpl) then) =
      __$$StateNotInitializedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StateNotInitializedImplCopyWithImpl<$Res>
    extends _$SplashStatesCopyWithImpl<$Res, _$StateNotInitializedImpl>
    implements _$$StateNotInitializedImplCopyWith<$Res> {
  __$$StateNotInitializedImplCopyWithImpl(_$StateNotInitializedImpl _value,
      $Res Function(_$StateNotInitializedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StateNotInitializedImpl implements _StateNotInitialized {
  const _$StateNotInitializedImpl();

  @override
  String toString() {
    return 'SplashStates.notInitialized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateNotInitializedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function(bool isFirstStart) initializationCompleted,
    required TResult Function(String locale) initializeLocale,
  }) {
    return notInitialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notInitialized,
    TResult? Function(bool isFirstStart)? initializationCompleted,
    TResult? Function(String locale)? initializeLocale,
  }) {
    return notInitialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function(bool isFirstStart)? initializationCompleted,
    TResult Function(String locale)? initializeLocale,
    required TResult orElse(),
  }) {
    if (notInitialized != null) {
      return notInitialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateNotInitialized value) notInitialized,
    required TResult Function(_StateInitializationCompleted value)
        initializationCompleted,
    required TResult Function(_StateInitializeLocale value) initializeLocale,
  }) {
    return notInitialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateNotInitialized value)? notInitialized,
    TResult? Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult? Function(_StateInitializeLocale value)? initializeLocale,
  }) {
    return notInitialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNotInitialized value)? notInitialized,
    TResult Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult Function(_StateInitializeLocale value)? initializeLocale,
    required TResult orElse(),
  }) {
    if (notInitialized != null) {
      return notInitialized(this);
    }
    return orElse();
  }
}

abstract class _StateNotInitialized implements SplashStates {
  const factory _StateNotInitialized() = _$StateNotInitializedImpl;
}

/// @nodoc
abstract class _$$StateInitializationCompletedImplCopyWith<$Res> {
  factory _$$StateInitializationCompletedImplCopyWith(
          _$StateInitializationCompletedImpl value,
          $Res Function(_$StateInitializationCompletedImpl) then) =
      __$$StateInitializationCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isFirstStart});
}

/// @nodoc
class __$$StateInitializationCompletedImplCopyWithImpl<$Res>
    extends _$SplashStatesCopyWithImpl<$Res, _$StateInitializationCompletedImpl>
    implements _$$StateInitializationCompletedImplCopyWith<$Res> {
  __$$StateInitializationCompletedImplCopyWithImpl(
      _$StateInitializationCompletedImpl _value,
      $Res Function(_$StateInitializationCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFirstStart = null,
  }) {
    return _then(_$StateInitializationCompletedImpl(
      isFirstStart: null == isFirstStart
          ? _value.isFirstStart
          : isFirstStart // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StateInitializationCompletedImpl
    implements _StateInitializationCompleted {
  const _$StateInitializationCompletedImpl({required this.isFirstStart});

  @override
  final bool isFirstStart;

  @override
  String toString() {
    return 'SplashStates.initializationCompleted(isFirstStart: $isFirstStart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateInitializationCompletedImpl &&
            (identical(other.isFirstStart, isFirstStart) ||
                other.isFirstStart == isFirstStart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFirstStart);

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateInitializationCompletedImplCopyWith<
          _$StateInitializationCompletedImpl>
      get copyWith => __$$StateInitializationCompletedImplCopyWithImpl<
          _$StateInitializationCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function(bool isFirstStart) initializationCompleted,
    required TResult Function(String locale) initializeLocale,
  }) {
    return initializationCompleted(isFirstStart);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notInitialized,
    TResult? Function(bool isFirstStart)? initializationCompleted,
    TResult? Function(String locale)? initializeLocale,
  }) {
    return initializationCompleted?.call(isFirstStart);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function(bool isFirstStart)? initializationCompleted,
    TResult Function(String locale)? initializeLocale,
    required TResult orElse(),
  }) {
    if (initializationCompleted != null) {
      return initializationCompleted(isFirstStart);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateNotInitialized value) notInitialized,
    required TResult Function(_StateInitializationCompleted value)
        initializationCompleted,
    required TResult Function(_StateInitializeLocale value) initializeLocale,
  }) {
    return initializationCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateNotInitialized value)? notInitialized,
    TResult? Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult? Function(_StateInitializeLocale value)? initializeLocale,
  }) {
    return initializationCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNotInitialized value)? notInitialized,
    TResult Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult Function(_StateInitializeLocale value)? initializeLocale,
    required TResult orElse(),
  }) {
    if (initializationCompleted != null) {
      return initializationCompleted(this);
    }
    return orElse();
  }
}

abstract class _StateInitializationCompleted implements SplashStates {
  const factory _StateInitializationCompleted(
      {required final bool isFirstStart}) = _$StateInitializationCompletedImpl;

  bool get isFirstStart;

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateInitializationCompletedImplCopyWith<
          _$StateInitializationCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StateInitializeLocaleImplCopyWith<$Res> {
  factory _$$StateInitializeLocaleImplCopyWith(
          _$StateInitializeLocaleImpl value,
          $Res Function(_$StateInitializeLocaleImpl) then) =
      __$$StateInitializeLocaleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String locale});
}

/// @nodoc
class __$$StateInitializeLocaleImplCopyWithImpl<$Res>
    extends _$SplashStatesCopyWithImpl<$Res, _$StateInitializeLocaleImpl>
    implements _$$StateInitializeLocaleImplCopyWith<$Res> {
  __$$StateInitializeLocaleImplCopyWithImpl(_$StateInitializeLocaleImpl _value,
      $Res Function(_$StateInitializeLocaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
  }) {
    return _then(_$StateInitializeLocaleImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StateInitializeLocaleImpl implements _StateInitializeLocale {
  const _$StateInitializeLocaleImpl({required this.locale});

  @override
  final String locale;

  @override
  String toString() {
    return 'SplashStates.initializeLocale(locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateInitializeLocaleImpl &&
            (identical(other.locale, locale) || other.locale == locale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale);

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateInitializeLocaleImplCopyWith<_$StateInitializeLocaleImpl>
      get copyWith => __$$StateInitializeLocaleImplCopyWithImpl<
          _$StateInitializeLocaleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notInitialized,
    required TResult Function(bool isFirstStart) initializationCompleted,
    required TResult Function(String locale) initializeLocale,
  }) {
    return initializeLocale(locale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notInitialized,
    TResult? Function(bool isFirstStart)? initializationCompleted,
    TResult? Function(String locale)? initializeLocale,
  }) {
    return initializeLocale?.call(locale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notInitialized,
    TResult Function(bool isFirstStart)? initializationCompleted,
    TResult Function(String locale)? initializeLocale,
    required TResult orElse(),
  }) {
    if (initializeLocale != null) {
      return initializeLocale(locale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateNotInitialized value) notInitialized,
    required TResult Function(_StateInitializationCompleted value)
        initializationCompleted,
    required TResult Function(_StateInitializeLocale value) initializeLocale,
  }) {
    return initializeLocale(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateNotInitialized value)? notInitialized,
    TResult? Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult? Function(_StateInitializeLocale value)? initializeLocale,
  }) {
    return initializeLocale?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateNotInitialized value)? notInitialized,
    TResult Function(_StateInitializationCompleted value)?
        initializationCompleted,
    TResult Function(_StateInitializeLocale value)? initializeLocale,
    required TResult orElse(),
  }) {
    if (initializeLocale != null) {
      return initializeLocale(this);
    }
    return orElse();
  }
}

abstract class _StateInitializeLocale implements SplashStates {
  const factory _StateInitializeLocale({required final String locale}) =
      _$StateInitializeLocaleImpl;

  String get locale;

  /// Create a copy of SplashStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateInitializeLocaleImplCopyWith<_$StateInitializeLocaleImpl>
      get copyWith => throw _privateConstructorUsedError;
}
