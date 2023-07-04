import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;

/// Primary Button
class AdaptiveFilledButton extends AdaptiveWidgetInterface {
  const AdaptiveFilledButton({
    super.key,
    this.onPressed,
    required this.child,
    this.padding,
    this.alignment,
    this.color,
    this.disabledColor,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.focusable = true,
    this.clipBehaviour = Clip.none,
    this.onLongPress,
    this.borderRadius,
  });

  final void Function()? onPressed;

  final Widget child;

  // final // TODO: Implement AdaptiveVisualDensity
  // final // VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  // final double? splashRadius;
  final Color? color;
  // final Color? focusColor;
  // final Color? hoverColor;
  // final Color? highlightColor;
  // final Color? splashColor;
  final Color? disabledColor;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus /* = false */;
  // final String? tooltip;
  // final bool? enableFeedback;
  // final BoxConstraints? constraints;
  // final ButtonStyle? style;
  // final bool? isSelected;
  // final Widget? selectedIcon;

  final Clip clipBehaviour;

  /// Only in fluent
  final bool focusable;

  final VoidCallback? onLongPress;

  final BorderRadius? borderRadius;

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    return cupertino.CupertinoButton.filled(
      onPressed: onPressed,
      alignment: alignment ?? Alignment.center,
      borderRadius: borderRadius,
      disabledColor:
          disabledColor ?? cupertino.CupertinoColors.quaternarySystemFill,
      // minSize: minSize,
      padding: padding,
      // pressedOpacity: pressedOpacity,
      child: child,
    );
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    return fluent.FilledButton(
      onPressed: onPressed,
      autofocus: autofocus,
      focusNode: focusNode,
      focusable: focusable,
      onLongPress: onLongPress,
      // onTapDown: onTapDown,
      // onTapUp: onTapUp,
      // style: buttonStyle,
      child: child,
    );
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    return macos.PushButton(
      // TODO: resolve button size.
      buttonSize: macos.ButtonSize.large,
      alignment: alignment ?? Alignment.center,
      borderRadius: borderRadius,
      color: color,
      disabledColor: disabledColor,
      isSecondary: false,
      mouseCursor: mouseCursor,
      onPressed: onPressed,
      padding: padding,
      // pressedOpacity: pressedOpacity,
      // semanticLabel: semanticLabel,
      // buttonSize: ,
      // buttonSize: macos.ButtonSize,
      child: child,
    );
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    return material.FilledButton(
      child: child,
      onPressed: onPressed,
      autofocus: autofocus,
      clipBehavior: clipBehaviour,
      focusNode: focusNode,
      // onFocusChange: onFocusChange,
      // onHover: onHover,
      onLongPress: onLongPress,
      // statesController: statesController,
      // style: buttonStyle,
    );
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) =>
      materialWidgetBuilder(context);
}
