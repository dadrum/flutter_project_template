// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/widgets.dart';

// **************************************************************************
// DepGen code generator
// **************************************************************************

import 'package:app_template/application/splash/splash_bloc.dart';
import 'package:app_template/application/auth_controller/auth_controller_bloc.dart';
import 'package:app_template/domain/interfaces/i_api_facade.dart';
import 'package:app_template/domain/interfaces/i_local_cache.dart';
import 'package:app_template/domain/interfaces/i_authenticate_controller.dart';

  
class Di extends InheritedWidget {
  final Map<Type, Object> environment;

  // ---------------------------------------------------------------------------
  const Di({Key? key, required Widget child, required this.environment})
      : super(key: key, child: child);

  // ---------------------------------------------------------------------------
  static Di of(BuildContext context) {
    final Di? di = context.findAncestorWidgetOfExactType<Di>();
    if (di == null) {
      throw UnimplementedError('Di is not initialized in context');
    }
    return di;
  }

  // ---------------------------------------------------------------------------
  @override
  bool updateShouldNotify(Di oldWidget) {
    return false;
  }

  // ---------------------------------------------------------------------------
  T g<T>() => environment[T] as T;

  // ---------------------------------------------------------------------------
  T? mayBeGet<T>() => environment.containsKey(T) ? environment[T] as T : null;

  

  // ---------------------------------------------------------------------------
  SplashBloc buildSplashBloc(
  ) => SplashBloc(
      authenticateController: g<IAuthenticateController>(),
      localCache: g<ILocalCache>(),
      api: g<IApiFacade>(),
    );


  // ---------------------------------------------------------------------------
  AuthControllerBloc buildAuthControllerBloc(
  ) => AuthControllerBloc(
      authenticateController: g<IAuthenticateController>(),
      api: g<IApiFacade>(),
    );

}