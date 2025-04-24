import 'package:flutter/material.dart';

final class DSColorScheme {
  final DSColor primary;
  final DSColor secondary;
  final DSColor tertiary;
  final DSColor success;
  final DSColor error;
  final DSColor light;
  final DSColor dark;
  final DSColor disabled;
  final DSColor backgroundDisabled;
  const DSColorScheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.success,
    required this.error,
    required this.light,
    required this.dark,
    required this.disabled,
    required this.backgroundDisabled,
  });
}

class DSColor {
  final Color color;
  final bool isLight;

  DSColor({required this.color, required this.isLight});
}
