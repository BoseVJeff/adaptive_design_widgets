import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru/yaru.dart' as yaru;

class AdaptiveTheme {
  const AdaptiveTheme({
    required this.materialTheme,
    required this.materialDarkTheme,
    required this.materialHighContrastTheme,
    required this.materialHighContrastDarkTheme,
    required this.cupertinoTheme,
    required this.fluentTheme,
    required this.fluentDarkTheme,
    required this.macosTheme,
    required this.macosDarkTheme,
    required this.yaruTheme,
    required this.yaruDarkTheme,
  });

  factory AdaptiveTheme.defaultTheme() {
    return AdaptiveTheme(
      materialTheme: material.ThemeData.light(useMaterial3: true),
      materialDarkTheme: material.ThemeData.dark(useMaterial3: true),
      materialHighContrastTheme: material.ThemeData(
        colorScheme: const material.ColorScheme.highContrastLight(),
        useMaterial3: true,
      ),
      materialHighContrastDarkTheme: material.ThemeData(
        colorScheme: const material.ColorScheme.highContrastDark(),
        useMaterial3: true,
      ),
      cupertinoTheme: const cupertino.CupertinoThemeData(),
      fluentTheme: fluent.FluentThemeData(brightness: Brightness.light),
      fluentDarkTheme: fluent.FluentThemeData(brightness: Brightness.dark),
      macosTheme: macos.MacosThemeData.light(),
      macosDarkTheme: macos.MacosThemeData.dark(),
      yaruTheme: yaru.yaruLight,
      yaruDarkTheme: yaru.yaruDark,
    );
  }

  final material.ThemeData materialTheme;
  final material.ThemeData materialDarkTheme;
  final material.ThemeData materialHighContrastTheme;
  final material.ThemeData materialHighContrastDarkTheme;

  final cupertino.CupertinoThemeData cupertinoTheme;

  final fluent.FluentThemeData fluentTheme;
  final fluent.FluentThemeData fluentDarkTheme;

  final macos.MacosThemeData macosTheme;
  final macos.MacosThemeData macosDarkTheme;

  final material.ThemeData yaruTheme;
  final material.ThemeData yaruDarkTheme;
}
