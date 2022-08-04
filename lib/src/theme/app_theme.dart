import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red));
}
