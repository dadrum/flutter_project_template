import 'package:flutter/material.dart';

// http://mcg.mbitson.com/#!?mcgpalette0=%23044188 - generating primaryswatch
// https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4 - opacity to color table

class Palette {
  Palette.night()
      : palettePrimaryValue = 0xFF2A81CD,
        primarySwatch = const MaterialColor(0xFFFF0000, <int, Color>{
          50: Color(0xFFffe0e0),
          100: Color(0xFFffb3b3),
          200: Color(0xFFff8080),
          300: Color(0xFFff4d4d),
          400: Color(0xFFff2626),
          500: Color(0xFFff0000),
          600: Color(0xFFff0000),
          700: Color(0xFFff0000),
          800: Color(0xFFff0000),
          900: Color(0xFFff0000),
        }),

        // Палитра макета (Night)
        red = const Color(0xFFFF0000),
        green = const Color(0xFF1DB548),
        orange = const Color(0xFFFE5301),
        black1 = const Color(0xFF141414),
        black2 = const Color(0xFF303030),
        grey1 = const Color(0xFF757575),
        grey2 = const Color(0xFFC1C1C1),
        white = const Color(0xFFFFFFFF),

        // Нестандартные цвета палитры
        disabledButton = const Color(0xFF585858),
        buttonActiveText = const Color(0xFFFFFFFF),
        boxShadow = const Color(0x19000000),
        buttonActiveShadow = const Color(0xB2FE5301),
        transactionPayment = const Color(0xFFFF0000),
        transactionDeposit = const Color(0xFF1DB548),
        transactionFailed = const Color(0xFFC37C11),
        transactionPending = const Color(0xFF888888),
        progressIndicator = const Color(0xFFFED116),

        // Дополнительные цвета палитры
        dialogsBarrierColor = const Color(0x80000000);

  Palette.day()
      : palettePrimaryValue = 0xFFFF0000,
        primarySwatch = const MaterialColor(0xFFFF0000, <int, Color>{
          50: Color(0xFFffe0e0),
          100: Color(0xFFffb3b3),
          200: Color(0xFFff8080),
          300: Color(0xFFff4d4d),
          400: Color(0xFFff2626),
          500: Color(0xFFff0000),
          600: Color(0xFFff0000),
          700: Color(0xFFff0000),
          800: Color(0xFFff0000),
          900: Color(0xFFff0000),
        }),

        // Палитра макета (Day)
        red = const Color(0xFFFF0000),
        green = const Color(0xFF1DB548),
        orange = const Color(0xFFFE5301),
        black1 = const Color(0xFFF2F2F2),
        black2 = const Color(0xFFFFFFFF),
        grey1 = const Color(0xFFA5A5A5),
        grey2 = const Color(0xFF888888),
        white = const Color(0xFF141414),

        // Нестандартные цвета элементов интерфейса (Day):
        disabledButton = const Color(0xFF585858),
        buttonActiveText = const Color(0xFFFFFFFF),
        boxShadow = const Color(0x19000000),
        buttonActiveShadow = const Color(0xB2FE5301),
        transactionPayment = const Color(0xFFFF0000),
        transactionDeposit = const Color(0xFF1DB548),
        transactionFailed = const Color(0xFFC37C11),
        transactionPending = const Color(0xFF888888),
        progressIndicator = const Color(0x00FED116),

        // Дополнительные цвета палитры
        dialogsBarrierColor = const Color(0x80000000);

  final int palettePrimaryValue;

  final MaterialColor primarySwatch;

  // Палитра макета;
  final Color red;
  final Color green;
  final Color orange;
  final Color black1;
  final Color black2;
  final Color grey1;
  final Color grey2;
  final Color white;

  // Нестандартные цвета элементов интерфейса:
  final Color disabledButton;
  final Color buttonActiveShadow;
  final Color buttonActiveText;
  final Color boxShadow;
  final Color transactionPayment;
  final Color transactionDeposit;
  final Color transactionFailed;
  final Color transactionPending;
  final Color progressIndicator;

  // Дополнительные цвета палитры
  final Color dialogsBarrierColor;
}
