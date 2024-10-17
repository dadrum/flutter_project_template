import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'domain/environment/builders.dep_gen.dart';
import 'domain/environment/environment.dart';
import 'domain/error_logger/error_logger.dart';
import 'domain/interfaces/i_error_logger.dart';
import 'l10n/locale_provider.dart';
import 'presentation/navigation/top_route.dart';
import 'presentation/screens/developer_widgets/developer_widgets.dart';
import 'presentation/theme/dynamic_theme.dart';
import 'presentation/values/strings.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // retain the display of the native splash screen:
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize Firebase:
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // add a handler for messages that arrive when the app is not in use:
  // FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

  // create an instance of custom error logger
  final IErrorLogger errorLogger = CustomErrorLogger();

  // installing error handlers:
  _addExceptionsHandlers(errorLogger);

  // creating an instance of Environment and registering errorLogger in it:
  // dep_gen: Optimizing Dependency Management in Flutter
  // https://medium.com/@dadrum7/dep-gen-optimizing-dependency-management-in-flutter-7066290d84a7?source=friends_link&sk=6cf765fb6ea2a318666104ea9fc181ce
  final environment = Environment()..registry<IErrorLogger>(errorLogger);

  runApp(
    DepProvider(
      environment: (await environment.prepare()).lock(),
      child: const DynamicTheme(
        child: LocaleProvider(
          child: Application(),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeveloperWidgets(
      child: MaterialApp(
        title: Strings.appName,
        initialRoute: TopRoute.routeSplash,
        routes: TopRoute.routes(),
        theme: DynamicTheme.themeOf(context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: LocaleProvider.of(context)!.locale,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Добавляет обработчики исключений
void _addExceptionsHandlers(IErrorLogger analytics) {
  // Handle Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    analytics.onError(error: details.exception, stacktrace: details.stack);
  };

  // A callback that is invoked when an unhandled error occurs in the root isolate.
  PlatformDispatcher.instance.onError = (error, stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    analytics.onError(error: error, stacktrace: stack);
    return true;
  };
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// Top-level function handler
// @pragma('vm:entry-point')
// Future<void> _onBackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   PushManager.instance.parseRemoteNotification(
//     message,
//     MessageType.background,
//   );
// }
