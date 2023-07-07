import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart' as material;

class AdaptiveListTile extends AdaptiveWidgetInterface {
  const AdaptiveListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
  });

  final Widget title;

  final Widget? subtitle;

  final Widget? leading;

  // Not in macos
  // final Widget? trailing;

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    return cupertino.CupertinoListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
    );
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    return fluent.ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
    );
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    return macos.MacosListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
    );
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    return material.ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
    );
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) =>
      materialWidgetBuilder(context);
}
