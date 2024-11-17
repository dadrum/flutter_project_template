import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../l10n/locale_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.texts.authScreenTitle),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.texts.commonScreenName('Auth')),
              ElevatedButton(
                  onPressed: () {
                    LocaleProvider.of(context)!.setLocale(const Locale('en'));
                  },
                  child: const Text('EN')),
              ElevatedButton(
                  onPressed: () {
                    LocaleProvider.of(context)!.setLocale(const Locale('ru'));
                  },
                  child: const Text('RU')),
            ],
          ),
        ));
  }
}
