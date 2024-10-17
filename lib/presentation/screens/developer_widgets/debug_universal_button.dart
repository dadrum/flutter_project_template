import 'package:flutter/material.dart';

import 'common_developer_button.dart';

/// Универсальная кнопка
class DebugUniversalButton extends StatelessWidget {
  const DebugUniversalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDeveloperButton(
      icon: Icons.tag,
      onTap: () {
        // TODO(Pavel): #Unimplemented
        // сюда можно повесить любой код
      },
    );
  }
}
