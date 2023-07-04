import 'dart:ui';

import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_icon/design_icon.dart';
import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_icon/plus_icon.dart';
import 'package:adaptive_design_widgets/src/consts/design_system.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdaptiveIcon {
  AdaptiveIcon._();

  static designIcon({
    final double? fill,
    final double? size,
    final double? weight,
    final double? grade,
    final double? opticalSize,
    final Color? color,
    final List<Shadow>? shadows,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      DesignIcon(
        color: color,
        fill: fill,
        grade: grade,
        opticalSize: opticalSize,
        semanticLabel: semanticLabel,
        shadows: shadows,
        size: size,
        textDirection: textDirection,
        weight: weight,
      );

  static plusIcon({
    final double? fill,
    final double? size,
    final double? weight,
    final double? grade,
    final double? opticalSize,
    final Color? color,
    final List<Shadow>? shadows,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      PlusIcon(
        color: color,
        fill: fill,
        grade: grade,
        opticalSize: opticalSize,
        semanticLabel: semanticLabel,
        shadows: shadows,
        size: size,
        textDirection: textDirection,
        weight: weight,
      );

  // Special case icon for each supported icon/design system.
  // Icons used here are the icons for each company.
  // iOS and MacOS use the store icon as they would otherwise would have the same 'Apple' logo.
  // Using FA for all icons as that seems to have all of the icons.
  // Ideally, each platform would have the icons for all other platforms, but this is not the case so we stay here.
  static androidIcon({
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      FaIcon(
        FontAwesomeIcons.android,
        color: color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      );

  static cupertinoIcon({
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      FaIcon(
        FontAwesomeIcons.appStoreIos,
        color: color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      );

  static macosIcon({
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      FaIcon(
        FontAwesomeIcons.appStore,
        color: color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      );

  // Using Microsoft here as Fluent design is apparently a revamp of the so-called Microsoft Design System.
  // Source: https://en.wikipedia.org/wiki/Fluent_Design_System
  // Source 2: https://www.theverge.com/2017/5/11/15615812/microsoft-fluent-design-system-project-neon-features
  static fluentIcon({
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      FaIcon(
        FontAwesomeIcons.microsoft,
        color: color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      );

  // Using Ubuntu logo here as yaru seems to be primarily a Ubuntu thing.
  static yaruIcon({
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      FaIcon(
        FontAwesomeIcons.ubuntu,
        color: color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      );

  static fontAwesomeIcon({
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) =>
      FaIcon(
        FontAwesomeIcons.fontAwesome,
        color: color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      );

  // Conveniece method to get the icon for a given design system.
  static getIconOf(
    DesignSystem designSystem, {
    final double? size,
    final Color? color,
    final String? semanticLabel,
    final TextDirection? textDirection,
  }) {
    switch (designSystem) {
      case DesignSystem.cupertino:
        return cupertinoIcon(
          color: color,
          semanticLabel: semanticLabel,
          size: size,
          textDirection: textDirection,
        );
      case DesignSystem.fluent:
        return fluentIcon(
          color: color,
          semanticLabel: semanticLabel,
          size: size,
          textDirection: textDirection,
        );
      case DesignSystem.macos:
        return macosIcon(
          color: color,
          semanticLabel: semanticLabel,
          size: size,
          textDirection: textDirection,
        );
      case DesignSystem.material:
        return androidIcon(
          color: color,
          semanticLabel: semanticLabel,
          size: size,
          textDirection: textDirection,
        );
      case DesignSystem.yaru:
        return yaruIcon(
          color: color,
          semanticLabel: semanticLabel,
          size: size,
          textDirection: textDirection,
        );
      case DesignSystem.platform:
        return getIconOf(DesignSystem.platformDesignSystem());
    }
  }
}
