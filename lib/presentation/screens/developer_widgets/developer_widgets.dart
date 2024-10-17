import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_logger/app_logger_screen.dart';
import 'common_developer_button.dart';
import 'debug_auth_button.dart';
import 'debug_locale_button.dart';
import 'debug_theme_button.dart';
import 'debug_universal_button.dart';
import 'dynamic_media_query.dart';
import 'text_scale_settings.dart';

class DeveloperWidgets extends StatefulWidget {
  const DeveloperWidgets({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<DeveloperWidgets> createState() => _DeveloperWidgetsState();
}

class _DeveloperWidgetsState extends State<DeveloperWidgets> {
  bool _developerModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: DynamicMediaQuery(
          child: Stack(fit: StackFit.expand, children: [
            widget.child,
            if (_developerModeEnabled) ...[
              /// Authorize
              const Positioned(
                right: 4,
                bottom: 64 + 24 + 3 * CommonDeveloperButton.size,
                child: DebugAuthButton(),
              ),

              /// Theme
              const Positioned(
                right: 4,
                bottom: 64 + 16 + 2 * CommonDeveloperButton.size,
                child: DebugThemeButton(),
              ),

              /// Language
              const Positioned(
                right: 4,
                bottom: 64 + 8 + CommonDeveloperButton.size,
                child: DebugLocaleButton(),
              ),

              /// log screen
              const AppLoggerScreen(
                  bottom: 64 + 32 + 4 * CommonDeveloperButton.size),

              /// a screen with a text scale
              const Positioned(
                right: 4,
                bottom: 64 + 40 + 5 * CommonDeveloperButton.size,
                child: TextScaleSettings(),
              ),

              /// Universal button
              const Positioned(
                right: 4,
                bottom: 64 + 48 + 6 * CommonDeveloperButton.size,
                child: DebugUniversalButton(),
              ),
            ],

            /// the settings display button
            if (kDebugMode)
              Positioned(
                  right: 4,
                  bottom: 64,
                  child: CommonDeveloperButton(
                    icon: Icons.settings,
                    onTap: () => setState(() {
                      _developerModeEnabled = !_developerModeEnabled;
                    }),
                  )),
          ]),
        ));
  }
}
