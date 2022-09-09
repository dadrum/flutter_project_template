import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../application/splash/splash_bloc.dart';
import '../../../domain/environment/di.dart';
import '../../navigation/top_route.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('onboard'),
      ),
      body: Center(child: TextButton(
          child: Text('SKIP'),
        onPressed: () => _onSkipOnBoarding(context),
      ),)
    );

  }

  // ---------------------------------------------------------------------------
  void _onSkipOnBoarding(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(TopRoute.routeAuthController);
  }
}
