import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/models/theme_type.dart';
import 'presentation/theme/themes.dart';
import 'presentation/values/palette.dart';

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class DynamicTheme extends StatefulWidget {
  const DynamicTheme({
    Key? key,
    this.initialThemeKey,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final ThemeTypes? initialThemeKey;

  @override
  _DynamicThemeState createState() => _DynamicThemeState();

  // ---------------------------------------------------------------------------
  static ThemeData? themeOf(BuildContext context) {
    final _DynamicThemeInherited? inherited =
    context.dependOnInheritedWidgetOfExactType<_DynamicThemeInherited>();
    return inherited?.data.theme;
  }

  // ---------------------------------------------------------------------------
  static _DynamicThemeState? instanceOf(BuildContext context) {
    final _DynamicThemeInherited? inherited =
    context.dependOnInheritedWidgetOfExactType<_DynamicThemeInherited>();
    return inherited?.data;
  }

  // ---------------------------------------------------------------------------
  static Palette paletteOf(BuildContext context) {
    final _DynamicThemeInherited? inherited =
    context.dependOnInheritedWidgetOfExactType<_DynamicThemeInherited>();
    return inherited?.data.palette ?? Palette.day();
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _DynamicThemeState extends State<DynamicTheme> {
  late ThemeData _theme;
  late Palette _palette;
  late ThemeTypes _themeType;

  late bool isThemeInitialized;

  ThemeData get theme => _theme;

  Palette get palette => _palette;

  ThemeTypes get themeType => _themeType;

  // ---------------------------------------------------------------------------
  @override
  void initState() {
    isThemeInitialized = false;
    if (widget.initialThemeKey != null) {
      _themeType = widget.initialThemeKey!;
      _palette = ThemeBuilder.getPalette(widget.initialThemeKey!);
      _theme = ThemeBuilder.getTheme(widget.initialThemeKey!, _palette);
    }
    super.initState();
  }

  // ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (widget.initialThemeKey == null && !isThemeInitialized) {
      final Brightness systemBrightness =
          MediaQuery.of(context).platformBrightness;
      if (systemBrightness == Brightness.dark) {
        _themeType = ThemeTypes.night;
        _palette = ThemeBuilder.getPalette(_themeType);
        _theme = ThemeBuilder.getTheme(_themeType, _palette);
      } else {
        _themeType = ThemeTypes.day;
        _palette = ThemeBuilder.getPalette(_themeType);
        _theme = ThemeBuilder.getTheme(_themeType, _palette);
      }
      isThemeInitialized = true;
    }
    super.didChangeDependencies();
  }

  // ---------------------------------------------------------------------------
  void changeTheme(ThemeTypes themeKey) {
    setState(() {
      _themeType = themeKey;
      _palette = ThemeBuilder.getPalette(themeKey);
      _theme = ThemeBuilder.getTheme(themeKey, _palette);
    });
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return _DynamicThemeInherited(
        data: this,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            /// The brightness of the top status bar icons.
            /// Only honored in Android version M and greater.
            statusBarIconBrightness: _themeType != ThemeTypes.night
                ? Brightness.dark
                : Brightness.light,

            /// The brightness of top status bar.
            /// Only honored in iOS.
            statusBarBrightness: _themeType != ThemeTypes.night
                ? Brightness.light
                : Brightness.dark,

            /// The color of the system bottom navigation bar.
            /// Only honored in Android versions O and greater.
            systemNavigationBarColor: _palette.black1,

            /// The brightness of the system navigation bar icons.
            /// Only honored in Android versions O and greater.
            systemNavigationBarIconBrightness:
            _theme.brightness == Brightness.dark
                ? Brightness.dark
                : Brightness.light,
          ),
          child: widget.child,
        ));
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _DynamicThemeInherited extends InheritedWidget {
  const _DynamicThemeInherited({
    required this.data,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);
  final _DynamicThemeState data;

  @override
  bool updateShouldNotify(_DynamicThemeInherited oldWidget) {
    return true;
  }
}
