import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../l10n/locale_provider.dart';
import '../presentation/screens/developer_widgets/developer_widgets.dart';
import '../presentation/theme/dynamic_theme.dart';
import 'constants/strings.dart';
import 'navigation/top_route.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeveloperWidgets(
      child: MaterialApp(
        title: Strings.appName,
        initialRoute: TopRoute.routeSplash,
        routes: TopRoute.routes(),
        theme: DynamicTheme.themeOf(context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: LocaleProvider.of(context)!.locale,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
