import 'package:flutter/material.dart';

class ThemePallete {
  static const blueColor = Color.fromRGBO(12, 121, 250, 1);
  static const greyColor = Color.fromRGBO(224, 224, 224, 1);

  static var defaultAppTheme = ThemeData.light().copyWith(
    primaryColor: blueColor,
    scaffoldBackgroundColor: greyColor,
    useMaterial3: true,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'NunitoBold',
        fontSize: 34,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'NunitoRegular',
      ),
      bodySmall: TextStyle(
        fontFamily: 'NunitoItalic',
        fontSize: 18,
      ),
      labelMedium: TextStyle(
        fontFamily: 'NunitoSemiBold',
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
      ),
    ),
  );
}
