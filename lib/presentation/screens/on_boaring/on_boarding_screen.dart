import 'package:flutter/material.dart';

import '../../../l10n/locale_provider.dart';
import '../../navigation/top_route.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: LocaleProvider.of(context)!.locale,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('onboard'),
            ),
            body: Center(
              child: TextButton(
                child: const Text('SKIP'),
                onPressed: () => _onSkipOnBoarding(context),
              ),
            )));
  }

  // ---------------------------------------------------------------------------
  void _onSkipOnBoarding(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(TopRoute.routeAuthController);
  }
}
