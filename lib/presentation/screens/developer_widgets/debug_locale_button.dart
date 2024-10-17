import 'package:flutter/material.dart';

import '../../../l10n/locale_provider.dart';
import 'common_developer_button.dart';

/// A button that allows you to change the language of the application
class DebugLocaleButton extends StatefulWidget {
  const DebugLocaleButton({Key? key}) : super(key: key);

  @override
  State<DebugLocaleButton> createState() => DebugLocaleButtonState();
}

class DebugLocaleButtonState extends State<DebugLocaleButton> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = LocaleProvider.of(context);

    return CommonDeveloperButton(
      icon: Icons.language,
      onTap: () {
        if (localeProvider?.locale?.languageCode.contains('ru') ?? true) {
          // context.depGen().g<IApiFacade>().setAppClientLocale('en');
          localeProvider?.setLocale(const Locale('en'));
        } else {
          // context.depGen().g<IApiFacade>().setAppClientLocale('ru');
          localeProvider?.setLocale(const Locale('ru'));
        }
      },
    );
  }
}
