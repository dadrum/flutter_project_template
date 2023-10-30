// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

import 'dart:collection';

import 'package:flutter/widgets.dart';

// **************************************************************************
// DepGen code generator
// **************************************************************************

import 'package:app_template/domain/interfaces/i_api_facade.dart';
import 'package:app_template/domain/interfaces/i_local_cache.dart';
import 'package:app_template/domain/interfaces/i_authenticate_controller.dart';
import 'package:app_template/presentation/navigation/auth_controller/bloc/auth_controller_bloc.dart';
import 'package:app_template/presentation/screens/splash/bloc/splash_bloc.dart';


/// The environment in which all used dependency instances are configured
@immutable
class DepGenEnvironment {
  DepGenEnvironment({Map<Type, Object>? initialServices})
      : _environment = initialServices ?? {};

  late final Map<Type, Object> _environment;

  // ---------------------------------------------------------------------------
  /// An unsafe method for getting an instance by its type. You need to be sure
  /// that an instance of the requested type has been registered
  T g<T>() => _environment[T] as T;

  // ---------------------------------------------------------------------------
  /// A safe method for trying to get an instance by its type.
  T? mayBeGet<T>() => _environment.containsKey(T) ? _environment[T] as T : null;

  // ---------------------------------------------------------------------------
  /// Registration of an instance with an indication of its type. You cannot
  /// register multiple instances of the same type
  void registry<T>(Object instance) => _environment[T] = instance;

  // ---------------------------------------------------------------------------
  /// Is the collection of instances blocked
  bool get isLocked => _environment is UnmodifiableMapView;

  // ---------------------------------------------------------------------------
  /// Returns an instance of the environment settings with the collection
  /// blocked from changes
  DepGenEnvironment lock() {
    return DepGenEnvironment(initialServices: Map.unmodifiable(_environment));
  }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
extension DepProviderContextExtension on BuildContext {
  /// Obtain a value from the nearest ancestor DepProvider.
  DepProvider depGen() => DepProvider.of(this);
}
  
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
class DepProvider extends InheritedWidget {
  const DepProvider({
    Key? key,
    required Widget child,
    required DepGenEnvironment environment,
  })  : _env = environment,
        super(key: key, child: child);
        
  // --------------------------------------------------------------------------- 
  /// A pre-configured environment containing the dependencies used 
  final DepGenEnvironment _env;

  // ---------------------------------------------------------------------------
  static DepProvider of(BuildContext context) {
    final DepProvider? dp = context.findAncestorWidgetOfExactType<DepProvider>();
    if (dp == null) {
      throw UnimplementedError('DepProvider is not initialized in context');
    }
    return dp;
  }

  // ---------------------------------------------------------------------------
  @override
  bool updateShouldNotify(DepProvider oldWidget) {
    return false;
  }

  // ---------------------------------------------------------------------------
  /// An unsafe method for getting an instance by its type. You need to be sure
  /// that an instance of the requested type has been registered
  T g<T>() => _env.g<T>();

  // ---------------------------------------------------------------------------
  /// A safe method for trying to get an instance by its type.
  T? mayBeGet<T>() => _env.mayBeGet<T>();

  

  // ---------------------------------------------------------------------------
  AuthControllerBloc buildAuthControllerBloc(
  ) => AuthControllerBloc(
      authenticateController: _env.g<IAuthenticateController>(),
      api: _env.g<IApiFacade>(),
    );


  // ---------------------------------------------------------------------------
  SplashBloc buildSplashBloc(
  ) => SplashBloc(
      authenticateController: _env.g<IAuthenticateController>(),
      localCache: _env.g<ILocalCache>(),
      api: _env.g<IApiFacade>(),
    );

}