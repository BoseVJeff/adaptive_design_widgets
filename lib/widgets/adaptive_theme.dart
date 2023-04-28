import 'package:adaptive_design_widgets/adaptive_widget_interface.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru/yaru.dart' as yaru;

class AdaptiveThemeData {
  const AdaptiveThemeData({
    this.materialThemeData,
    this.cupertinoThemeData,
    this.fluentThemeData,
    this.macosThemeData,
    this.yaruThemeData,
  });

  final material.ThemeData? materialThemeData;
  final cupertino.CupertinoThemeData? cupertinoThemeData;
  final fluent.FluentThemeData? fluentThemeData;
  final macos.MacosThemeData? macosThemeData;
  final material.ThemeData? yaruThemeData;

  factory AdaptiveThemeData.light() => AdaptiveThemeData(
        materialThemeData: material.ThemeData.light(useMaterial3: true),
        cupertinoThemeData:
            const cupertino.CupertinoThemeData(brightness: Brightness.light),
        fluentThemeData: fluent.FluentThemeData.light(),
        macosThemeData: macos.MacosThemeData.light(),
        yaruThemeData: yaru.yaruLight,
      );

  factory AdaptiveThemeData.dark() => AdaptiveThemeData(
        materialThemeData: material.ThemeData.dark(useMaterial3: true),
        cupertinoThemeData:
            const cupertino.CupertinoThemeData(brightness: Brightness.dark),
        fluentThemeData: fluent.FluentThemeData.dark(),
        macosThemeData: macos.MacosThemeData.dark(),
        yaruThemeData: yaru.yaruDark,
      );

  // TODO: Finish implementing this
  /* factory AdaptiveThemeData.fromMaterialThemeData(
    material.ThemeData themeData,
  ) {
    return AdaptiveThemeData(
      themeData,
      material.MaterialBasedCupertinoThemeData(materialTheme: themeData),
      fluent.FluentThemeData(
        accentColor: fluent.Colors.blue,
      ),
      macos.MacosThemeData(),
    );
  } */
}

enum AdaptiveThemeMode {
  light,
  dark,
  system,
}
