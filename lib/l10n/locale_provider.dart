import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class LocaleProvider extends StatefulWidget {
  const LocaleProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;

  @override
  _LocaleProviderState createState() => _LocaleProviderState();

  // ---------------------------------------------------------------------------
  static _LocaleProviderState? of(BuildContext context) {
    final _LocaleProviderInherited? inherited =
        context.dependOnInheritedWidgetOfExactType<_LocaleProviderInherited>();
    return inherited?.data;
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _LocaleProviderState extends State<LocaleProvider> {
  Locale? _locale;

  Locale? get locale => _locale;

  // ---------------------------------------------------------------------------
  void setLocale(Locale locale) {
    if (LocaleProvider.supportedLocales.contains(locale)) {
      setState(() {
        _locale = locale;
      });
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return _LocaleProviderInherited(
      data: this,
      child: widget.child,
    );
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _LocaleProviderInherited extends InheritedWidget {
  const _LocaleProviderInherited({
    required this.data,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);
  final _LocaleProviderState data;

  @override
  bool updateShouldNotify(_LocaleProviderInherited oldWidget) {
    return true;
  }
}
