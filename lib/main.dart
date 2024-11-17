import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/application.dart';
import 'core/environment/builders.dep_gen.dart';
import 'core/environment/environment.dart';
import 'core/errors/i_error_logger.dart';
import 'data/error_logger/error_logger.dart';
import 'l10n/locale_provider.dart';
import 'presentation/theme/dynamic_theme.dart';

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
      environment: await environment.prepare(),
      child: Builder(builder: (context) {
        environment.registryUseCases(context.depGen());
        return const DynamicTheme(
          child: LocaleProvider(
            child: Application(),
          ),
        );
      }),
    ),
  );
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
