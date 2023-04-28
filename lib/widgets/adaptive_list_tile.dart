import 'package:adaptive_design_widgets/adaptive_widget_interface.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru_widgets/yaru_widgets.dart' as yaru_widgets;
import 'package:chicago/chicago.dart' as chicago;

class AdaptiveListTile extends AdaptiveWidgetInterface {
  const AdaptiveListTile({
    required this.title,
    this.subTitle,
    this.leading,
    this.onTap,
    this.maxLeadingSize,
    super.key,
  });

  final Widget title;
  final Widget? subTitle;
  final Widget? leading;
  // No trailing as that is not present in macos_ui
  // final Widget? trailing;
  final VoidCallback? onTap;

  /// Constrain the size of the leading widget to a fraction of the total size of the [AdaptiveListTile]. Value should be between 0.0 and 1.0 .
  ///
  /// This is a purely convenience widget and is implemented using a [SizedBox] as the parent widget of the provided [leading] widget.
  /// The values are a fraction of the layout as that seems to be the most useful.
  final double? maxLeadingSize;

  @override
  material.Widget buildCupertinoWidget(material.BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        cupertino.CupertinoListTile(
          title: title,
          subtitle: subTitle,
          leading: leading,
          onTap: onTap,
        ),
      ],
    );
  }

  @override
  material.Widget buildFluentWidget(material.BuildContext context) {
    return fluent.ListTile(
      title: title,
      subtitle: subTitle,
      leading: leading,
      onPressed: onTap,
    );
  }

  @override
  material.Widget buildMacosWidget(material.BuildContext context) {
    return macos.MacosListTile(
      title: title,
      subtitle: subTitle,
      leading: leading,
      onClick: onTap,
    );
  }

  @override
  material.Widget buildMaterialWidget(material.BuildContext context) {
    return material.ListTile(
      title: title,
      subtitle: subTitle,
      leading: leading,
      onTap: onTap,
    );
  }

  @override
  Widget buildYaruWidget(BuildContext context) {
    // Not using [YaruTile] here as that does not have an onTap listner
    // TODO: See if it is viable to use YaruMasterTile if onTap is present and YaruTile if it is null
    return yaru_widgets.YaruMasterTile(
      title: title,
      subtitle: subTitle,
      leading: leading,
      onTap: onTap,
    );
  }
}
