import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../application/splash/splash_bloc.dart';
import '../../../domain/environment/di.dart';
import '../../navigation/top_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => Di.of(context).buildSplashBloc(),
      child: BlocConsumer<SplashBloc, SplashStates>(
        listenWhen: (_, state) => state.maybeMap(
            initializationCompleted: (_) => true,
            initializeLocale: (_) => true,
            orElse: () => false),
        buildWhen: (_, state) => state.maybeMap(
          notInitialized: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.mapOrNull(
            initializeLocale: (state) =>
                initializeLocale(context, state.locale),
            initializationCompleted: (state) =>
                _navigateToAppNavigationRouter(context, state.isFirstStart),
          );
        },
        builder: (context, state) {
          return const Scaffold();
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  Future<void> initializeLocale(BuildContext context, String locale) async {
    Locale setLocale = locale.toLowerCase().contains('ru')
        ? const Locale('ru', 'RU')
        : const Locale('en', 'US');

    await EasyLocalization.of(context)?.setLocale(setLocale);
  }

  // ---------------------------------------------------------------------------
  Future<void> _navigateToAppNavigationRouter(
      BuildContext context, bool isFirstStart) async {
    // Hide native splash
    FlutterNativeSplash.remove();

    if (isFirstStart) {
      Navigator.of(context).pushReplacementNamed(TopRoute.routeOnBoarding);
    } else {
      Navigator.of(context).pushReplacementNamed(TopRoute.routeAuthController);
    }
  }
}
