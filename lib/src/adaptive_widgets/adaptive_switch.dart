import 'package:adaptive_design_widgets/src/adaptive_interface.dart';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart' as material;
import 'package:yaru_widgets/widgets.dart' as yaru;

class AdaptiveSwitch extends AdaptiveWidgetInterface {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;

  final void Function(bool newValue) onChanged;

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    return cupertino.CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    return fluent.ToggleSwitch(
      checked: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    return macos.MacosSwitch(
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    return material.Switch(
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) {
    return yaru.YaruSwitch(
      value: value,
      onChanged: onChanged,
    );
  }
}
