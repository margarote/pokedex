import 'package:flutter/material.dart';

abstract class AppTypography {
  static const titleMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0.36,
  );

  static const bodySmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.28,
  );

  static const displayMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 36 / 36,
    letterSpacing: 0,
  );

  static const displayLarge = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 40,
    height: 44 / 40,
    letterSpacing: 0,
  );

  static const headlineLarge = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 32,
  );

  static const bodyMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.32,
  );
}
