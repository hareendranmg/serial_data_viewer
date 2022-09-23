import 'package:flutter/material.dart';

// const bodyBackgroundColor = Color.fromRGBO(214, 214, 214, 1);
// const bodyBackgroundColor = Color(0xFFE9E9E9);
const primaryColor = Colors.indigo;
const Color textColor = Color(0xFF121212);
const textColorMedGrey = Color(0xFF202020);
const textColorGrey = Color(0xFF616161);

final themeData = ThemeData().copyWith(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch(accentColor: primaryColor),
  scaffoldBackgroundColor: Colors.indigo.shade50,
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: primaryColor),
      foregroundColor: primaryColor,
    ),
  ),
);

const screenPadding = EdgeInsets.all(12);
final borderRadius = BorderRadius.circular(12);

const customOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
);
