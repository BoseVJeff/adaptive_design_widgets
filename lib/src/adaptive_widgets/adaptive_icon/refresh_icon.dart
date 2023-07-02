import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:material_symbols_icons/symbols.dart';
import 'package:yaru_icons/yaru_icons.dart';

/// Indicates a refresh
class RefreshIcon extends AdaptiveIconInterface {
  const RefreshIcon({
    super.key,
    super.fill,
    super.size,
    super.weight,
    super.grade,
    super.opticalSize,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
  });

  const RefreshIcon.filled({
    super.key,
    super.fill,
    super.size,
    super.weight,
    super.grade,
    super.opticalSize,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
  }) : super.filled();

  @override
  IconData cupertinoIcon(double? size) {
    return CupertinoIcons.refresh;
  }

  @override
  IconData cupertinoIconFilled(double? size) {
    return CupertinoIcons.refresh_thick;
  }

  @override
  IconData fluentIcon(double? size) {
    return FluentIcons.refresh;
  }

  @override
  IconData fluentIconFilled(double? size) {
    return FluentIcons.refresh;
  }

  @override
  IconData fontAwesomeIcon(double? size) {
    return FontAwesomeIcons.arrowsRotate;
  }

  @override
  IconData fontAwesomeIconFilled(double? size) {
    return FontAwesomeIcons.arrowsRotate;
  }

  @override
  IconData materialIcon(double? size) {
    return material.Icons.refresh;
  }

  @override
  IconData materialIconFilled(double? size) {
    return Icons.refresh_sharp;
  }

  @override
  IconData materialSymbolsIcon(double? size) {
    return Symbols.refresh;
  }

  @override
  IconData materialSymbolsIconFilled(double? size) {
    return Symbols.refresh_sharp;
  }

// 16, 20, 24
  @override
  IconData msFluentIcon(double? size) {
    if (size != null) {
      if (size < 18) {
        return ms.FluentIcons.arrow_rotate_clockwise_16_regular;
      } else if (size < 22) {
        return ms.FluentIcons.arrow_rotate_clockwise_20_regular;
      } else {
        return ms.FluentIcons.arrow_rotate_clockwise_24_regular;
      }
    } else {
      return ms.FluentIcons.arrow_rotate_clockwise_24_regular;
    }
  }

  @override
  IconData msFluentIconFilled(double? size) {
    if (size != null) {
      if (size < 18) {
        return ms.FluentIcons.arrow_rotate_clockwise_16_filled;
      } else if (size < 22) {
        return ms.FluentIcons.arrow_rotate_clockwise_20_filled;
      } else {
        return ms.FluentIcons.arrow_rotate_clockwise_24_filled;
      }
    } else {
      return ms.FluentIcons.arrow_rotate_clockwise_24_filled;
    }
  }

  @override
  IconData yaruIcon(double? size) {
    return YaruIcons.refresh;
  }

  @override
  IconData yaruIconFilled(double? size) {
    return YaruIcons.refresh;
  }
}
