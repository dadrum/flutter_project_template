import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/models/theme_type.dart';
import '../values/palette.dart';
import '../values/values.dart';

// https://docs.google.com/spreadsheets/u/0/d/1vraGWxcY_7xS5vpxlzuF5G0M6Vyj8gLhEVf7K1ynx5o/htmlview#gid=0

class ThemeBuilder {
  static const TextStyle _globalTextStyle =
      TextStyle(fontFamily: 'Inter', fontFamilyFallback: ['sans-serif']);

  // ---------------------------------------------------------------------------
  static Palette getPalette(ThemeTypes type) {
    switch (type) {
      case ThemeTypes.light:
        return Palette.light();
      case ThemeTypes.dark:
        return Palette.dark();
    }
  }

  // ---------------------------------------------------------------------------
  static ThemeData getTheme(ThemeTypes type, Palette palette) {
    switch (type) {
      case ThemeTypes.light:
        return _getDayTheme(palette);
      case ThemeTypes.dark:
        return _getNightTheme(palette);
    }
  }

  // ---------------------------------------------------------------------------
  static ThemeData _getDayTheme(Palette palette) => ThemeData(
        primarySwatch: palette.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        popupMenuTheme: PopupMenuThemeData(
          color: palette.black1,
        ),

        primaryColor: palette.red,
        useMaterial3: Platform.isAndroid,

        scaffoldBackgroundColor: palette.black1,

        appBarTheme: AppBarTheme(
            color: palette.black1,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent, // !!
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light, //!!
              systemNavigationBarIconBrightness: Brightness.dark,
            )),

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: palette.primarySwatch,
          accentColor: palette.red,
          cardColor: palette.black1,
          backgroundColor: palette.black1,
          errorColor: palette.red,
          brightness: Brightness.dark,
        ).copyWith(surfaceContainerHighest: Colors.transparent),

        splashColor: palette.orange.withOpacity(0.06),
        highlightColor: palette.orange.withOpacity(0.06),
        splashFactory: InkRipple.splashFactory,

        timePickerTheme: TimePickerThemeData(
            backgroundColor: palette.black1,
            dialBackgroundColor: palette.black2,
            // dayPeriodColor: Colors.orangeAccent,
            // dayPeriodTextColor: Colors.brown,
            dialHandColor: palette.orange,
            dialTextColor: palette.white,
            entryModeIconColor: palette.white,
            hourMinuteColor: palette.black2,
            hourMinuteTextColor: palette.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Values.dialogRadius),
            )),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          // backgroundColor: palette.clean60,
          backgroundColor: palette.black1,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: palette.white),
          unselectedIconTheme: IconThemeData(color: palette.white),
          selectedItemColor: palette.white,
          unselectedItemColor: palette.white,
          selectedLabelStyle: _globalTextStyle.copyWith(
            fontSize: 12,
            color: palette.white,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: _globalTextStyle.copyWith(
            fontSize: 12,
            color: palette.white,
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
          backgroundColor: palette.black1,
          // elevation,
          actionsPadding: const EdgeInsets.only(bottom: 20),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Values.dialogRadius),
          ),
          titleTextStyle: _globalTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: palette.white,
          ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
            modalBarrierColor: Colors.transparent,
            modalBackgroundColor: palette.black2,
            modalElevation: 3,
            backgroundColor: palette.black1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Values.dialogRadius)),
            )),

        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Values.buttonRadius),
          ),
          buttonColor: palette.red,
          disabledColor: palette.primarySwatch.shade300,
          height: 54,
        ),

        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor:
                WidgetStatePropertyAll<Color>(palette.orange.withOpacity(0.06)),
          ),
        ),

        textTheme: TextTheme(
          // Headline 1
          headlineMedium: TextStyle(
            fontSize: 20,
            // height: 1.17,
            height: 1,
            fontWeight: FontWeight.w700,
            // regular
            color: palette.white,
            decoration: TextDecoration.none,
          ),

          titleLarge: TextStyle(
            fontSize: 30,
            height: 1,
            fontWeight: FontWeight.w700,
            // regular
            color: palette.white,
            decoration: TextDecoration.none,
          ),

          // Headline 2
          titleMedium: TextStyle(
            fontSize: 16,
            height: 1,
            fontWeight: FontWeight.w700,
            // regular
            color: palette.white,
            decoration: TextDecoration.none,
          ),

          // Text 1
          bodyLarge: _globalTextStyle.copyWith(
              fontSize: 14,
              // height: 1.07,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decoration: TextDecoration.none),

          // Text 2
          bodyMedium: _globalTextStyle.copyWith(
              fontSize: 12,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decoration: TextDecoration.none),

          // Text 3
          bodySmall: _globalTextStyle.copyWith(
              fontSize: 10,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decoration: TextDecoration.none),

          // Button_Text
          labelMedium: _globalTextStyle.copyWith(
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.w700,
              color: palette.white,
              decoration: TextDecoration.none),

          // Link 1
          labelSmall: _globalTextStyle.copyWith(
              fontSize: 14,
              // height: 1.5,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decorationColor: palette.white,
              decoration: TextDecoration.underline),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: palette.white,
          unselectedLabelColor: palette.white,
        ),
      );

  // ---------------------------------------------------------------------------
  static ThemeData _getNightTheme(Palette palette) => ThemeData(
        primarySwatch: palette.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        popupMenuTheme: PopupMenuThemeData(
          color: palette.black1,
        ),

        primaryColor: palette.red,
        useMaterial3: Platform.isAndroid,

        scaffoldBackgroundColor: palette.black1,

        appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            color: palette.black1,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent, // !!
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light, //!!
              systemNavigationBarIconBrightness: Brightness.dark,
            )),

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: palette.primarySwatch,
          accentColor: palette.red,
          cardColor: palette.black1,
          backgroundColor: palette.black1,
          errorColor: palette.red,
          brightness: Brightness.dark,
        ).copyWith(surfaceContainerHighest: Colors.transparent),

        splashColor: palette.orange.withOpacity(0.06),
        highlightColor: palette.orange.withOpacity(0.06),
        splashFactory: InkRipple.splashFactory,

        timePickerTheme: TimePickerThemeData(
          backgroundColor: palette.black2,
          dialBackgroundColor: palette.black1,
          // dayPeriodColor: Colors.orangeAccent,
          // dayPeriodTextColor: Colors.brown,
          dialHandColor: palette.orange,
          dialTextColor: palette.white,
          entryModeIconColor: palette.white,
          hourMinuteColor: palette.black1,
          hourMinuteTextColor: palette.white,
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: palette.black1,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: palette.white),
          unselectedIconTheme: IconThemeData(color: palette.white),
          selectedItemColor: palette.white,
          unselectedItemColor: palette.white,
          selectedLabelStyle: _globalTextStyle.copyWith(
            fontSize: 12,
            color: palette.white,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: _globalTextStyle.copyWith(
            fontSize: 12,
            color: palette.white,
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
          backgroundColor: palette.black1,
          // elevation,
          actionsPadding: const EdgeInsets.only(bottom: 20),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Values.dialogRadius),
          ),
          titleTextStyle: _globalTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: palette.white,
          ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
            modalBarrierColor: Colors.transparent,
            modalBackgroundColor: palette.black2,
            modalElevation: 3,
            backgroundColor: palette.black1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Values.dialogRadius)),
            )),

        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor:
                WidgetStatePropertyAll<Color>(palette.orange.withOpacity(0.06)),
          ),
        ),

        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Values.buttonRadius),
          ),
          buttonColor: palette.red,
          disabledColor: palette.primarySwatch.shade300,
          height: 54,
        ),
        textTheme: TextTheme(
          // Headline 1
          headlineMedium: TextStyle(
            fontSize: 20,
            // height: 1.17,
            height: 1,
            fontWeight: FontWeight.w700,
            // regular
            color: palette.white,
            decoration: TextDecoration.none,
          ),

          titleLarge: TextStyle(
            fontSize: 30,
            height: 1,
            fontWeight: FontWeight.w700,
            // regular
            color: palette.white,
            decoration: TextDecoration.none,
          ),

          // Headline 2
          titleMedium: TextStyle(
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.w700,
            // regular
            color: palette.white,
            decoration: TextDecoration.none,
          ),

          // Text 1
          bodyLarge: _globalTextStyle.copyWith(
              fontSize: 14,
              // height: 1.07,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decoration: TextDecoration.none),

          // Text 2
          bodyMedium: _globalTextStyle.copyWith(
              fontSize: 12,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decoration: TextDecoration.none),

          // Text 3
          bodySmall: _globalTextStyle.copyWith(
              fontSize: 10,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decoration: TextDecoration.none),

          // Button_Text
          labelMedium: _globalTextStyle.copyWith(
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.w700,
              color: palette.white,
              decoration: TextDecoration.none),

          // Link 1
          labelSmall: _globalTextStyle.copyWith(
              fontSize: 14,
              // height: 1.5,
              height: 1,
              fontWeight: FontWeight.w400,
              color: palette.white,
              decorationColor: palette.white,
              decoration: TextDecoration.underline),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: palette.white,
          unselectedLabelColor: palette.white,
        ),
      );
}
