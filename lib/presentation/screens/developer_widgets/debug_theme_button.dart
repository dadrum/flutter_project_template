import 'package:flutter/material.dart';

import '../../../domain/models/theme_type.dart';
import '../../theme/dynamic_theme.dart';
import 'common_developer_button.dart';

/// A button that allows you to change the theme of the application
class DebugThemeButton extends StatefulWidget {
  const DebugThemeButton({Key? key}) : super(key: key);

  @override
  State<DebugThemeButton> createState() => DebugThemeButtonState();
}

class DebugThemeButtonState extends State<DebugThemeButton> {
  @override
  Widget build(BuildContext context) {
    final dynamicTheme = DynamicTheme.instanceOf(context);

    return CommonDeveloperButton(
      icon: dynamicTheme.isLightTheme ? Icons.sunny : Icons.nightlight_outlined,
      onTap: () {
        if (dynamicTheme.isLightTheme) {
          dynamicTheme.changeTheme(ThemeTypes.dark);
        } else {
          dynamicTheme.changeTheme(ThemeTypes.light);
        }
      },
    );
  }
}
