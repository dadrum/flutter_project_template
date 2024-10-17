import 'dart:async';

import 'package:flutter/material.dart';

import 'common_developer_button.dart';

/// A button that allows you to enter and exit the application using fake tokens
///
class DebugAuthButton extends StatefulWidget {
  const DebugAuthButton({Key? key}) : super(key: key);

  @override
  State<DebugAuthButton> createState() => DebugAuthButtonState();
}

class DebugAuthButtonState extends State<DebugAuthButton> {
  Future<void> updateAfterDelay() async {
    unawaited(
      Future<void>.delayed(const Duration(milliseconds: 200)).then((value) {
        if (context.mounted) setState(() {});
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final authenticateRepository =
    //     context.depGen().g<IAuthenticateRepository>();
    //
    // final api = context.depGen().g<IApiFacade>();
    //
    // final userAuthorized = authenticateRepository.controller.status ==
    //     AuthenticateStatus.authorized;

    // return userAuthorized
    //     ? CommonDeveloperButton(
    //         icon: Icons.logout,
    //         onTap: () async {
    //           // TODO(Pavel): #unimplemented
    //
    //         },
    //       )
    //     : CommonDeveloperButton(
    //         icon: Icons.login,
    //         onTap: () async {
    //           // TODO(Pavel): #unimplemented
    //         },
    //       );

    return CommonDeveloperButton(
      icon: Icons.login,
      onTap: () async {
        // TODO(Pavel): #unimplemented
      },
    );
  }
}
