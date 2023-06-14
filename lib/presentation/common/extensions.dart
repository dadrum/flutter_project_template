import 'package:flutter/material.dart';

// расширение для сокращенного доступа к стилям текста темы
extension FontTipography on BuildContext {
  // H1 заголовки
  TextStyle? get textStyle$Head => Theme.of(this).textTheme.headlineLarge;

  // Кнопки
  TextStyle? get textStyle$Button => Theme.of(this).textTheme.bodyLarge;

  // Подзаголовки
  TextStyle? get textStyle$Subtitle => Theme.of(this).textTheme.titleSmall;

  // Основной текст
  TextStyle? get textStyle$Body => Theme.of(this).textTheme.bodyMedium;

  // Меню
  TextStyle? get textStyle$Menu => Theme.of(this).textTheme.labelSmall;
}

extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}
