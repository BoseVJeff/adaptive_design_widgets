import 'package:adaptive_design_widgets/src/adaptive_interface.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:material_symbols_icons/symbols.dart';
import 'package:yaru_icons/yaru_icons.dart';

class PlusIcon extends AdaptiveIconInterface {
  const PlusIcon({
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

  const PlusIcon.filled({
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
    return CupertinoIcons.add;
  }

  @override
  IconData cupertinoIconFilled(double? size) {
    return CupertinoIcons.add;
  }

  @override
  IconData fluentIcon(double? size) {
    return FluentIcons.add;
  }

  @override
  IconData fluentIconFilled(double? size) {
    return FluentIcons.add;
  }

  @override
  IconData fontAwesomeIcon(double? size) {
    return FontAwesomeIcons.plus;
  }

  @override
  IconData fontAwesomeIconFilled(double? size) {
    return FontAwesomeIcons.plus;
  }

  @override
  IconData materialIcon(double? size) {
    return Icons.add;
  }

  @override
  IconData materialIconFilled(double? size) {
    return Icons.add;
  }

  @override
  IconData materialSymbolsIcon(double? size) {
    return Symbols.add;
  }

  @override
  IconData materialSymbolsIconFilled(double? size) {
    return Symbols.add;
  }

  @override
  IconData msFluentIcon(double? size) {
    if (size != null) {
      if (size < 14) {
        return ms.FluentIcons.add_12_regular;
      } else if (size >= 14 && size < 18) {
        return ms.FluentIcons.add_16_regular;
      } else if (size >= 18 && size < 22) {
        return ms.FluentIcons.add_20_regular;
      } else if (size >= 22 && size < 26) {
        return ms.FluentIcons.add_24_regular;
      } else if (size >= 26 && size < 30) {
        return ms.FluentIcons.add_28_regular;
      } else if (size >= 30 && size < 40) {
        return ms.FluentIcons.add_32_regular;
      } else {
        return ms.FluentIcons.add_48_regular;
      }
    } else {
      return ms.FluentIcons.add_48_regular;
    }
  }

  @override
  IconData msFluentIconFilled(double? size) {
    if (size != null) {
      if (size < 14) {
        return ms.FluentIcons.add_12_filled;
      } else if (size >= 14 && size < 18) {
        return ms.FluentIcons.add_16_filled;
      } else if (size >= 18 && size < 22) {
        return ms.FluentIcons.add_20_filled;
      } else if (size >= 22 && size < 26) {
        return ms.FluentIcons.add_24_filled;
      } else if (size >= 26 && size < 30) {
        return ms.FluentIcons.add_28_filled;
      } else if (size >= 30 && size < 40) {
        return ms.FluentIcons.add_32_filled;
      } else {
        return ms.FluentIcons.add_48_filled;
      }
    } else {
      return ms.FluentIcons.add_48_filled;
    }
  }

  @override
  IconData yaruIcon(double? size) {
    return YaruIcons.plus;
  }

  @override
  IconData yaruIconFilled(double? size) {
    return YaruIcons.plus;
  }
}
