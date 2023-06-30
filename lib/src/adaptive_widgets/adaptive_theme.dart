import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru/yaru.dart' as yaru;

class AdaptiveTheme {
  const AdaptiveTheme({
    this.materialLightTheme,
    this.materialDarkTheme,
    this.materialHighContrastLightTheme,
    this.materialHighContrastDarkTheme,
    this.cupertinoTheme,
    this.fluentTheme,
    this.fluentDarkTheme,
    this.macosTheme,
    this.macosDarkTheme,
    this.yaruTheme,
    this.yaruDarkTheme,
    this.yaruHighContrastLightTheme,
    this.yaruHighContrastDarkTheme,
  });

  static final AdaptiveTheme defaultTheme = AdaptiveTheme(
    materialLightTheme: material.ThemeData.light(useMaterial3: true),
    materialDarkTheme: material.ThemeData.dark(useMaterial3: true),
    materialHighContrastLightTheme: material.ThemeData(
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
    yaruHighContrastLightTheme: yaru.yaruHighContrastLight,
    yaruHighContrastDarkTheme: yaru.yaruHighContrastDark,
  );

  /* factory AdaptiveTheme.fromCorePalette(CorePalette corePalette) {
    Scheme lightScheme = Scheme.lightFromCorePalette(corePalette);
    Scheme darkScheme = Scheme.darkFromCorePalette(corePalette);

    material.ThemeData materialLight = material.ThemeData(
      colorScheme: corePalette.toColorScheme(brightness: Brightness.light),
      useMaterial3: true,
    );
    material.ThemeData materialDark = material.ThemeData(
      colorScheme: corePalette.toColorScheme(brightness: Brightness.dark),
      useMaterial3: true,
    );
    cupertino.CupertinoThemeData cupertinoTheme = cupertino.CupertinoThemeData(
      // Using the middle tone here.
      // Possible values: 0, 10 ,20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100
      // Docs on possible values: https://pub.dev/documentation/material_color_utilities/0.2.0/palettes_tonal_palette/TonalPalette/commonTones-constant.html
      // primaryColor: Color(corePalette.primary.get(50)),
      primaryColor: Color(lightScheme.primary),
      primaryContrastingColor: Color(lightScheme.onPrimary),
      scaffoldBackgroundColor: Color(lightScheme.background),
      barBackgroundColor: Color(lightScheme.primaryContainer),
      brightness: Brightness.light,
    );
    fluent.FluentThemeData fluentLightTheme = fluent.FluentThemeData(
      
    );
  } */

  final material.ThemeData? materialLightTheme;
  final material.ThemeData? materialDarkTheme;
  final material.ThemeData? materialHighContrastLightTheme;
  final material.ThemeData? materialHighContrastDarkTheme;

  final cupertino.CupertinoThemeData? cupertinoTheme;

  final fluent.FluentThemeData? fluentTheme;
  final fluent.FluentThemeData? fluentDarkTheme;

  final macos.MacosThemeData? macosTheme;
  final macos.MacosThemeData? macosDarkTheme;

  final material.ThemeData? yaruTheme;
  final material.ThemeData? yaruDarkTheme;
  final material.ThemeData? yaruHighContrastLightTheme;
  final material.ThemeData? yaruHighContrastDarkTheme;
}

/// The Theme mode of the Adaptive app.
///
/// This is necessary as [material.ThemeMode] and [fluent.ThemeMode] are distinct, incompatible classes
enum AdaptiveThemeMode {
  light(
    materialThemeMode: material.ThemeMode.light,
    fluentThemeMode: fluent.ThemeMode.light,
  ),
  dark(
    materialThemeMode: material.ThemeMode.dark,
    fluentThemeMode: fluent.ThemeMode.dark,
  ),
  system(
    materialThemeMode: material.ThemeMode.system,
    fluentThemeMode: fluent.ThemeMode.system,
  );

  const AdaptiveThemeMode({
    required this.materialThemeMode,
    required this.fluentThemeMode,
  });

  final material.ThemeMode materialThemeMode;
  final fluent.ThemeMode fluentThemeMode;

  factory AdaptiveThemeMode.fromBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return AdaptiveThemeMode.light;
      case Brightness.dark:
        return AdaptiveThemeMode.dark;
    }
  }
}
