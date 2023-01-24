import 'package:flutter/material.dart';

// расширение для сокращенного доступа к стилям текста темы
extension ContextFontExtention on BuildContext {
  TextStyle? get headline1Style => Theme.of(this).textTheme.headline1;

  TextStyle? get headline2Style => Theme.of(this).textTheme.headline2;

  TextStyle? get headline3Style => Theme.of(this).textTheme.headline3;

  TextStyle? get headline4Style => Theme.of(this).textTheme.headline4;

  TextStyle? get buttonStyle => Theme.of(this).textTheme.button;

  TextStyle? get subtitle1Style => Theme.of(this).textTheme.subtitle1;

  TextStyle? get subtitle2Style => Theme.of(this).textTheme.subtitle2;

  TextStyle? get bodyText1Style => Theme.of(this).textTheme.bodyText1;

  TextStyle? get bodyText2Style => Theme.of(this).textTheme.bodyText2;

  TextStyle? get overLineStyle => Theme.of(this).textTheme.overline;
}

extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}
