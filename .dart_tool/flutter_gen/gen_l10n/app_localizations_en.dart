import 'app_localizations.dart';

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
