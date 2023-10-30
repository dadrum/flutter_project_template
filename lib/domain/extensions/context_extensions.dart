import 'package:flutter/material.dart';

import '../../presentation/theme/dynamic_theme.dart';
import '../../presentation/values/palette.dart';

/// расширение для сокращенного доступа к стилям текста и цветам
extension ContextExtension on BuildContext {
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// Большие заголовки:
  ///
  /// fontSize: 20,
  ///
  /// fontWeight: FontWeight.w700,
  ///
  /// color: palette.font,
  TextStyle? get style20w700$Titles =>
      DynamicTheme.themeOf(this)?.textTheme.displayLarge;

  /// Средние заголовки:
  ///
  /// fontSize: 18,
  ///
  /// fontWeight: FontWeight.w600,
  ///
  /// color: palette.font,
  TextStyle? get style18w600$Titles =>
      DynamicTheme.themeOf(this)?.textTheme.displayLarge;

  /// Подписи на кнопках:
  ///
  /// fontSize: 16,
  ///
  /// fontWeight: FontWeight.w500,
  ///
  /// color: palette.font,
  TextStyle? get style16w500$Buttons =>
      DynamicTheme.themeOf(this)?.textTheme.labelLarge;

  /// Основной текст:
  ///
  /// fontSize: 16,
  ///
  /// fontWeight: FontWeight.w600,
  ///
  /// color: palette.font,
  TextStyle? get style16w600$Text =>
      DynamicTheme.themeOf(this)?.textTheme.bodyLarge;

  /// Надписи в TextField, в Checkbox:
  ///
  /// fontSize: 16,
  ///
  /// fontWeight: FontWeight.w400,
  ///
  /// color: palette.text,
  TextStyle? get style16w400$Fields =>
      DynamicTheme.themeOf(this)?.textTheme.titleSmall;

  /// Подписи:
  ///
  /// fontSize: 12,
  ///
  /// fontWeight: FontWeight.w400,
  ///
  /// color: palette.fontHints,
  TextStyle? get style12w400$Subtitles =>
      DynamicTheme.themeOf(this)?.textTheme.bodyMedium;

  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// Предоставляет динамическую палитру цветов
  Palette? get palette => DynamicTheme.paletteOf(this);
}
