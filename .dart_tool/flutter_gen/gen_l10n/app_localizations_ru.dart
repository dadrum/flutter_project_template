import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get authScreenTitle => 'Авторизация';

  @override
  String commonScreenName(String name) {
    return 'Это экран $name';
  }

  @override
  String get language => 'Русский';
}
