import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru_widgets/yaru_widgets.dart' as yaru;

class AdaptiveIconutton extends AdaptiveWidgetInterface {
  const AdaptiveIconutton({
    super.key,
    this.iconSize,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    // this.style,
    this.isSelected,
    this.selectedIcon,
    // this.visualDensity,
    required this.icon,
    this.focusable = true,
  });

  final double? iconSize;
  // final // TODO: Implement AdaptiveVisualDensity
  // final // VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final double? splashRadius;
  final Color? color;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? disabledColor;
  final /* required */ VoidCallback? onPressed;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus /* = false */;
  final String? tooltip;
  final bool? enableFeedback;
  final BoxConstraints? constraints;
  // final ButtonStyle? style;
  final bool? isSelected;
  final Widget? selectedIcon;

  /// Usually an [AdaptiveIcon]
  final Widget icon;

  /// Only in fluent
  final bool focusable;

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    // Taken from https://www.kindacode.com/article/flutter-cupertino-button-tutorial-and-examples/#Cupertino_icon_buttons
    return cupertino.CupertinoButton(
      onPressed: onPressed,
      // alignment: ,
      // borderRadius: ,
      color: color,
      // Using the default value used
      disabledColor:
          disabledColor ?? cupertino.CupertinoColors.quaternarySystemFill,
      // minSize: ,
      padding: padding,
      child: icon,
      // pressedOpacity: ,
    );
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    return fluent.IconButton(
      icon: icon,
      onPressed: onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      focusable: focusable,
      // tiny, small, large
      // iconButtonMode: fluent.IconButtonMode.,
      // onLongPress: ,
      // onTapDown: ,
      // onTapDown: ,
      // style: ,
    );
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    return macos.PushButton(
      // Can be large or small
      buttonSize: macos.ButtonSize.small,
      // alignment: ,
      // borderRadius: ,
      color: color,
      disabledColor: disabledColor,
      // isSecondary: ,
      mouseCursor: mouseCursor ?? SystemMouseCursors.basic,
      onPressed: onPressed,
      padding: padding,
      child: icon,
      // pressedOpacity: ,
      // semanticLabel: ,
    );
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    return material.IconButton(
      icon: icon,
      onPressed: onPressed,
      alignment: alignment,
      autofocus: autofocus,
      color: color,
      constraints: constraints,
      disabledColor: disabledColor,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusNode: focusNode,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      iconSize: iconSize,
      isSelected: isSelected,
      mouseCursor: mouseCursor,
      padding: padding,
      selectedIcon: selectedIcon,
      splashColor: splashColor,
      splashRadius: splashRadius,
      // style: ,
      tooltip: tooltip,
      // visualDensity: ,
    );
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) {
    return yaru.YaruIconButton(
      icon: icon,
      onPressed: onPressed,
      alignment: alignment ?? Alignment.center,
      autofocus: autofocus,
      constraints: constraints,
      enableFeedback: enableFeedback ?? true,
      focusNode: focusNode,
      iconSize: iconSize ?? 40.0,
      isSelected: isSelected,
      mouseCursor: mouseCursor,
      padding: padding ?? const EdgeInsets.all(8.0),
      selectedIcon: selectedIcon,
      splashRadius: splashRadius,
      // style: ,
      tooltip: tooltip,
      // visualDensity: ,
    );
  }
}
