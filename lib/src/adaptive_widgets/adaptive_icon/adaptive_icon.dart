import 'dart:ui';

import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_icon/design_icon.dart';

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
}
