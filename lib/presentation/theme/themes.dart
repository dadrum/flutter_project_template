import 'dart:io';

import 'package:flutter/material.dart';

import '../values/palette.dart';
import '../values/values.dart';

// https://docs.google.com/spreadsheets/u/0/d/1vraGWxcY_7xS5vpxlzuF5G0M6Vyj8gLhEVf7K1ynx5o/htmlview#gid=0

class AppTheme {
  static const TextStyle _globalTextStyle =
      TextStyle(fontFamily: 'Inter', fontFamilyFallback: ['sans-serif']);

  static ThemeData getTheme({double fontCoefficient = 1.0}) => ThemeData(
        primarySwatch: Palette.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        popupMenuTheme: const PopupMenuThemeData(
          color: Palette.background,
        ),

        // This is the background color of major parts of the app like toolbars,
        // tab bars, appbar, and many more.
        primaryColor: Palette.accent,
        useMaterial3: Platform.isAndroid,

        // This is the brightness of the primary color. It is used to determine
        // the color of text and icons placed on the top of the primary color.
        // primaryColorBrightness: Brightness.light,

        // This is a lighter version of primaryColor.
        // brightness: Brightness.light,

        // This is default color of MaterialType.canvas (Rectangle using default
        // theme canvas color)
        // canvasColor: palette.background,

        // Radio Button unselected Color

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Palette.primarySwatch,
          primaryColorDark: Palette.primarySwatch.shade600,
          accentColor: Palette.accent,
          cardColor: Palette.background,
          backgroundColor: Palette.background,
          errorColor: Palette.error,
          // brightness: Brightness.light,
        ),

        splashColor: Palette.splashBackground,
        splashFactory: InkRipple.splashFactory,

        /// The color of ink splashes. See [InkWell].
        highlightColor: Palette.accent.withOpacity(0.05),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Palette.clean,
          elevation: 0.0,
          selectedIconTheme: const IconThemeData(color: Palette.text),
          unselectedIconTheme: const IconThemeData(color: Palette.text),
          selectedItemColor: Palette.text,
          unselectedItemColor: Palette.text,
          selectedLabelStyle: _globalTextStyle.copyWith(
            fontSize: 12,
            color: Palette.text,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: _globalTextStyle.copyWith(
            fontSize: 12,
            color: Palette.text,
            fontWeight: FontWeight.w400,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
        ),

        //
        //
        checkboxTheme: CheckboxThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        //
        //
        dialogTheme: DialogTheme(
          backgroundColor: Palette.background,
          // elevation,
          actionsPadding: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Values.dialogRadius),
          ),
          titleTextStyle: _globalTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Palette.text,
          ),
        ),

        bottomSheetTheme: const BottomSheetThemeData(
            modalBarrierColor: Colors.transparent,
            modalBackgroundColor: Palette.clean,
            modalElevation: 3,
            backgroundColor: Palette.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Values.dialogRadius)),
            )),

        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Values.buttonRadius),
          ),
          buttonColor: Palette.accent,
          disabledColor: Palette.primarySwatch.shade300,
          height: 54,
        ),
        textTheme: TextTheme(
          // H1 заголовки
          headlineLarge: TextStyle(
              fontSize: 20 * fontCoefficient,
              fontWeight: FontWeight.w600, // regular
              color: Palette.text,
              decoration: TextDecoration.none),

          // Подзаголовки
          titleSmall: _globalTextStyle.copyWith(
              fontSize: 12 * fontCoefficient,
              fontWeight: FontWeight.w400, // 500
              color: Palette.text,
              decoration: TextDecoration.none),

          // Кнопки
          bodyLarge: _globalTextStyle.copyWith(
              fontSize: 15 * fontCoefficient,
              fontWeight: FontWeight.w500,
              color: Palette.text,
              decoration: TextDecoration.none),

          // Основной текст
          bodyMedium: _globalTextStyle.copyWith(
              fontSize: 15 * fontCoefficient,
              fontWeight: FontWeight.w400,
              color: Palette.text,
              decoration: TextDecoration.none),

          // Меню
          labelSmall: _globalTextStyle.copyWith(
              fontSize: 8 * fontCoefficient,
              fontWeight: FontWeight.w400,
              color: Palette.text,
              decoration: TextDecoration.none),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Palette.text,
          unselectedLabelColor: Palette.text,
        ),
      );
}
