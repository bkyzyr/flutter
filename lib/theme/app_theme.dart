import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ThemeData().colorScheme.primary,
      brightness: brightness,
    ),
  );
}