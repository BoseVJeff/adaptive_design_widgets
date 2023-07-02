import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:yaru_icons/yaru_icons.dart';

/// Icons rougly repersentative of the icon system.
///
/// This is puerly best-effort.
class DesignIcon extends AdaptiveIconInterface {
  const DesignIcon({
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

  const DesignIcon.filled({
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
    return CupertinoIcons.device_phone_portrait;
  }

  @override
  IconData cupertinoIconFilled(double? size) {
    return CupertinoIcons.device_phone_portrait;
  }

  @override
  IconData macosIcon(double? size) {
    return CupertinoIcons.device_desktop;
  }

  @override
  IconData macosIconFilled(double? size) {
    return CupertinoIcons.device_desktop;
  }

  @override
  IconData fluentIcon(double? size) {
    return FluentIcons.check_mark;
  }

  @override
  IconData fluentIconFilled(double? size) {
    return FluentIcons.check_mark;
  }

  @override
  IconData fontAwesomeIcon(double? size) {
    return FontAwesomeIcons.fontAwesome;
  }

  @override
  IconData fontAwesomeIconFilled(double? size) {
    return FontAwesomeIcons.solidFontAwesome;
  }

  @override
  IconData materialIcon(double? size) {
    return Icons.android_outlined;
  }

  @override
  IconData materialIconFilled(double? size) {
    return Icons.android;
  }

  @override
  IconData materialSymbolsIcon(double? size) {
    return Symbols.android_rounded;
  }

  @override
  IconData materialSymbolsIconFilled(double? size) {
    return Symbols.android;
  }

  @override
  IconData msFluentIcon(double? size) {
    if (size != null) {
      if (size < 18) {
        return ms.FluentIcons.store_microsoft_16_regular;
      } else if (size < 22) {
        return ms.FluentIcons.store_microsoft_20_regular;
      } else {
        return ms.FluentIcons.store_microsoft_24_regular;
      }
    } else {
      return ms.FluentIcons.store_microsoft_24_regular;
    }
  }

  @override
  IconData msFluentIconFilled(double? size) {
    if (size != null) {
      if (size < 18) {
        return ms.FluentIcons.store_microsoft_16_filled;
      } else if (size < 22) {
        return ms.FluentIcons.store_microsoft_20_filled;
      } else {
        return ms.FluentIcons.store_microsoft_24_filled;
      }
    } else {
      return ms.FluentIcons.store_microsoft_24_filled;
    }
  }

  // ubuntu_logo is the standard logo - solid background and logo in negative space inside
  // ubuntu_logo_simple is the logo itself with transparent background - used here as that seems appropriate
  // ubuntu_logo_large is the newer, large logo - solid rectangle with a logo in a negative space in the bottom of the rectangle
  @override
  IconData yaruIcon(double? size) {
    return YaruIcons.ubuntu_logo_simple;
  }

  @override
  IconData yaruIconFilled(double? size) {
    return YaruIcons.ubuntu_logo;
  }
}
