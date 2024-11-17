import 'package:flutter/widgets.dart';

import '../../presentation/auth_controller/auth_controller_screen.dart';
import '../../presentation/screens/on_boaring/on_boarding_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';

class TopRoute {
  static const String routeSplash = '/';
  static const String routeAuthController = '/authenticate_router';
  static const String routeOnBoarding = '/first_locale_selection';

  static Map<String, WidgetBuilder> routes() => {
        TopRoute.routeSplash: (context) => const SplashScreen(),
        TopRoute.routeAuthController: (context) => const AuthControllerScreen(),
        TopRoute.routeOnBoarding: (context) => const OnBoardingScreen(),
      };
}
