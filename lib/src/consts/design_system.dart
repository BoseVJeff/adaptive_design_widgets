import 'dart:io';

import 'package:adaptive_design_widgets/src/design_ancestor.dart';
import 'package:flutter/widgets.dart';

/// The list of design systems available in this package
enum DesignSystem {
  /// Refers to Material 3/Material You by Google
  ///
  /// Widgets: https://docs.flutter.dev/ui/widgets/material
  /// Docs: https://m3.material.io/get-started
  material,

  /// Refers to Material 2 by Google
  ///
  /// Widgets: https://docs.flutter.dev/ui/widgets/material2
  /// Docs: https://m2.material.io/design
  material2,

  /// Refers to the iOS design system by Apple
  ///
  /// Widgets: https://docs.flutter.dev/ui/widgets/cupertino
  cupertino,

  /// Refers to Fluent Design by Microsoft
  ///
  /// Widgets: https://pub.dev/packages/fluent_ui (Third Party, Flutter Favorite)
  /// Docs: https://docs.microsoft.com/en-us/windows/uwp/design
  /// Demo: https://bdlukaa.github.io/fluent_ui/
  fluent,

  /// Refers to the MacOS design system by Apple
  ///
  /// Widgets: https://pub.dev/packages/macos_ui (Third Party)
  /// Demo: https://groovinchip.github.io/macos_ui/#/
  macos,

  /// Refers to the Ubuntu design system by Cannonical
  ///
  /// Widgets: https://pub.dev/packages/yaru (Third Party - https://github.com/ubuntu)
  /// Demo: https://ubuntu.github.io/yaru.dart
  yaru;

  /// Set a value automatically based on the operating system.
  ///
  /// Values:
  /// Android/Fuchsia: [DesignSystem.material]
  /// iOS: [DesignSystem.cupertino]
  /// Windows: [DesignSystem.fluent]
  /// MacOS: [DesignSystem.macos]
  /// Linux: [DesignSystem.yaru]
  ///
  /// Operating system is determined by [Platform.operatingSystem]
  factory DesignSystem.platform() {
    String os = Platform.operatingSystem;
    switch (os) {
      case 'fuchsia':
      case 'android':
        return DesignSystem.material;
      case 'ios':
        return DesignSystem.cupertino;
      case 'windows':
        return DesignSystem.fluent;
      case 'macos':
        return DesignSystem.macos;
      case 'linux':
        return DesignSystem.yaru;
      default:
        return DesignSystem.material;
    }
  }

  static DesignSystem of(BuildContext context) =>
      DesignAncestorData.of(context).designSystem;
}
