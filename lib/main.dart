import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'domain/analytics/analytics.dart';
import 'domain/environment/builders.dep_gen.dart';
import 'domain/environment/environment.dart';
import 'domain/interfaces/i_analytics.dart';
import 'l10n/locale_provider.dart';
import 'presentation/navigation/top_route.dart';
import 'presentation/theme/dynamic_theme.dart';
import 'presentation/values/strings.dart';

Future<void> main() async {
  final IAnalytics analytics = Analytics();
  addExceptionsHandlers(analytics);

  runZonedGuarded(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // prepare environment
    final environment = Environment()..registry<IAnalytics>(analytics);

    runApp(
      DepProvider(
        environment: (await environment.prepare()).lock(),
        child: const DynamicTheme(child: LocaleProvider(child: Application())),
      ),
    );
  }, (error, stack) => analytics.onError(error: error, stacktrace: stack));
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
void addExceptionsHandlers(IAnalytics analytics) {
  //Handle Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    analytics.onError(error: details.exception, stacktrace: details.stack);
  };
  // A callback that is invoked when an unhandled error occurs in the root isolate.
  PlatformDispatcher.instance.onError = (error, stack) {
    analytics.onError(error: error, stacktrace: stack);
    return true;
  };
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      initialRoute: TopRoute.routeSplash,
      routes: TopRoute.routes(),
      theme: DynamicTheme.themeOf(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: LocaleProvider.of(context)!.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
