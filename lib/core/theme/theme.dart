import 'package:flutter/material.dart';

import 'style.dart';

class AppTheme {
  final lightTheme = ThemeData(
    primaryColor: primaryColor,
    primarySwatch: primarySwatchColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: whiteColor,
    fontFamily: "Tajawal",
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      thickness: MaterialStateProperty.all(5.0),
      thumbColor: MaterialStateProperty.all(primaryColor.withOpacity(0.4)),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: primaryColor, elevation: 0),
    highlightColor: primaryColor,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: primaryColor),
  );
}
