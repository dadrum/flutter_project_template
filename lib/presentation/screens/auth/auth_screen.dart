import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../l10n/locale_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.authScreenTitle),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.commonScreenName('Auth')),
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
