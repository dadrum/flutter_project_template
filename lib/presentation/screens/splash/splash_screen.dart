import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core/environment/builders.dep_gen.dart';
import '../../../core/navigation/top_route.dart';
import '../../../l10n/locale_provider.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => context.depGen().buildSplashBloc(),
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
    final setLocale = locale.toLowerCase().contains('ru')
        ? const Locale('ru', 'RU')
        : const Locale('en', 'US');

    LocaleProvider.of(context)?.setLocale(setLocale);
  }

  // ---------------------------------------------------------------------------
  Future<void> _navigateToAppNavigationRouter(
      BuildContext context, bool isFirstStart) async {
    // Hide native splash
    FlutterNativeSplash.remove();

    if (isFirstStart) {
      await Navigator.of(context)
          .pushReplacementNamed(TopRoute.routeOnBoarding);
    } else {
      await Navigator.of(context)
          .pushReplacementNamed(TopRoute.routeAuthController);
    }
  }
}
