import 'package:flutter/material.dart';

class Palette {
  static const int _palettePrimaryValue = 0xFF044188;

  //Primary
  static const Color primaryColor = Color(0xFF044188);

  // http://mcg.mbitson.com/#!?mcgpalette0=%23044188 - generating primaryswatch
  // https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4 - opacity to color table
  static const MaterialColor primarySwatch =
      MaterialColor(_palettePrimaryValue, <int, Color>{
    50: Color(0xFFe1e8f1),
    100: Color(0xFFb4c6db),
    200: Color(0xFF82a0c4),
    300: Color(0xFF4f7aac),
    400: Color(0xFF2a5e9a),
    500: Color(_palettePrimaryValue),
    600: Color(0xFF033b80),
    700: Color(0xFF033275),
    800: Color(0xFF022a6b),
    900: Color(0xFF011c58),
  });

  static const accent = Color(_palettePrimaryValue);
  static const background = Color(0xffF1F2F5);
  static const text = Color(0xff1C1C1C);
  static const clean = Color(0xffffffff);
  static const subtitles = Color(0xff5E5D5D);
  static const error = Color(0xffD34545);
  static const splashBackground = Color(0xFFe1e8f1);
}
