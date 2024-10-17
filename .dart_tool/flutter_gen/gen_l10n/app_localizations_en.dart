import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authScreenTitle => 'Auth title';

  @override
  String commonScreenName(String name) {
    return 'Screen $name';
  }

  @override
  String get language => 'English';
}
