import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'domain/analytics/analytics.dart';
import 'domain/environment/di.dart';
import 'domain/environment/environment.dart';
import 'domain/interfaces/i_analytics.dart';
import 'presentation/navigation/top_route.dart';
import 'presentation/values/strings.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final IAnalytics analytics = Analytics();
  addExceptionsHandlers(analytics);

  // prepare environment
  final environment = await Environment.buildEnvironment(
      initialMap: <Type, Object>{IAnalytics: analytics});

  runZonedGuarded(
      () => runApp(
            EasyLocalization(
                supportedLocales: const [
                  Locale('ru', 'RU'),
                  Locale('en', 'US')
                ],
                path: 'assets/languages',
                child: Di(
                  environment: environment,
                  child: const Application(),
                )),
          ),
      (error, stack) => analytics.onError(error: error, stacktrace: stack));
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
      theme: Theme.of(context),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
