import 'package:adaptive_design_widgets/adaptive_widget_interface.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;

class AdaptiveTextField extends AdaptiveWidgetInterface {
  const AdaptiveTextField({
    super.key,
    this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.placeholder,
    this.prefix,
    this.suffix,
  });

  final TextEditingController? controller;
  // Not included as `material` uses [material.InputDecoration] instead of [BoxDecoration]
  // TODO: Figure out a glue for this
  // final BoxDecoration decoration;
  final bool enabled;
  final bool obscureText;
  final String? placeholder;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return cupertino.CupertinoTextField(
      controller: controller,
      enabled: true,
      obscureText: obscureText,
      placeholder: placeholder,
      prefix: prefix,
      suffix: suffix,
    );
  }

  @override
  Widget buildFluentWidget(BuildContext context) {
    return fluent.TextBox(
      controller: controller,
      enabled: true,
      obscureText: obscureText,
      placeholder: placeholder,
      prefix: prefix,
      suffix: suffix,
    );
  }

  @override
  Widget buildMacosWidget(BuildContext context) {
    return macos.MacosTextField(
      controller: controller,
      enabled: true,
      obscureText: obscureText,
      placeholder: placeholder,
      prefix: prefix,
      suffix: suffix,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return material.TextField(
      controller: controller,
      enabled: true,
      obscureText: obscureText,
      decoration: material.InputDecoration(
        prefix: prefix,
        suffix: suffix,
        hintText: placeholder,
        /* border: material.OutlineInputBorder(
          borderSide: decoration.border,
          borderRadius: decoration.borderRadius
                  ?.resolve(Directionality.maybeOf(context)) ??
              const BorderRadius.all(
                Radius.circular(4.0),
              ),
        ), */
      ),
    );
  }

  @override
  Widget buildYaruWidget(BuildContext context) {
    // Using the material variant as suggested because YaruButton does not exist
    return buildMaterialWidget(context);
  }
}
