import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../presentation/theme/dynamic_theme.dart';
import '../../presentation/values/palette.dart';

/// extension for reduced access to text styles and colors
extension ContextExtension on BuildContext {
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// Big headlines:
  /// fontSize: 20,
  /// fontWeight: FontWeight.w700,
  /// color: palette.font,
  TextStyle? get style20w700$Titles =>
      DynamicTheme.themeOf(this)?.textTheme.displayLarge;

  /// Average headlines:
  /// fontSize: 18,
  /// fontWeight: FontWeight.w600,
  /// color: palette.font,
  TextStyle? get style18w600$Titles =>
      DynamicTheme.themeOf(this)?.textTheme.displayLarge;

  /// Captions on buttons:
  /// fontSize: 16,
  /// fontWeight: FontWeight.w500,
  /// color: palette.font,
  TextStyle? get style16w500$Buttons =>
      DynamicTheme.themeOf(this)?.textTheme.labelLarge;

  /// The main text:
  /// fontSize: 16,
  /// fontWeight: FontWeight.w600,
  /// color: palette.font,
  TextStyle? get style16w600$Text =>
      DynamicTheme.themeOf(this)?.textTheme.bodyLarge;

  /// Labels in TextField, in Checkbox:
  /// fontSize: 16,
  /// fontWeight: FontWeight.w400,
  /// color: palette.text,
  TextStyle? get style16w400$Fields =>
      DynamicTheme.themeOf(this)?.textTheme.titleSmall;

  /// Small labels
  /// fontSize: 12,
  /// fontWeight: FontWeight.w400,
  /// color: palette.fontHints,
  TextStyle? get style12w400$Subtitles =>
      DynamicTheme.themeOf(this)?.textTheme.bodyMedium;

  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// Provides a dynamic palette of colors
  Palette? get palette => DynamicTheme.paletteOf(this);

  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// Provides a dynamic set of texts and labels
  AppLocalizations get texts => AppLocalizations.of(this)!;
}
