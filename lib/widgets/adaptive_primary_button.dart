import 'package:adaptive_design_widgets/adaptive_widget_interface.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;

/// Returns the so-called 'Filled' variants of the buttons
class AdaptivePrimaryButton extends AdaptiveWidgetInterface {
  const AdaptivePrimaryButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  material.Widget buildCupertinoWidget(material.BuildContext context) {
    return cupertino.CupertinoButton.filled(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  material.Widget buildFluentWidget(material.BuildContext context) {
    return fluent.FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  material.Widget buildMacosWidget(material.BuildContext context) {
    return macos.PushButton(
      onPressed: onPressed,
      // Using a sensible default here
      buttonSize: macos.ButtonSize.small,
      child: child,
    );
  }

  @override
  material.Widget buildMaterialWidget(material.BuildContext context) {
    return material.ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget buildYaruWidget(BuildContext context) {
    // Using the material variant as suggested because YaruButton does not exist
    return buildMaterialWidget(context);
  }
}
