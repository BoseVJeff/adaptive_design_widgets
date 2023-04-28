import 'package:adaptive_design_widgets/design_system_provider.dart';
import 'package:adaptive_design_widgets/design_systems.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class AdaptiveIconInterface extends StatelessWidget {
  const AdaptiveIconInterface({super.key});

  /// Equivalent icon in the Material Icon set.
  ///
  /// This returns the [Icons] wrapped in a [Icon] widget
  Widget buildMaterialIcon(BuildContext context);

  /// Equivalent icon in the Cupertino icon set.
  ///
  /// This returns the equivalent [CupertinoIcon] in a [Icon] widget.
  Widget buildCupertinoIcon(BuildContext context);

  /// Equivalent icon in the Fluent design icon set.
  ///
  /// This returns the [FluentIcons] in a [Icon] widget.
  Widget buildFluentIcon(BuildContext context);

  /// Equivalent icon in the MacOS icon set.
  ///
  /// This returns the [CupertinoIcon] in a [MacosIcon] widget
  Widget buildMacosIcon(BuildContext context);

  /// Equivalent icon in the Font Awesome icon set
  ///
  /// This returns the IconData wraapped in a [FaIcon] widget
  Widget buildFontAwesomeIcon(BuildContext context);

  /// Equivalent icon in the Yaru icon set.
  ///
  /// This returns the IconData in a [Icon] widget.
  Widget buildYaruIcon(BuildContext context);

  @override
  Widget build(BuildContext context) {
    IconSystem iconSystem =
        Provider.of<DesignSystemProvider>(context).iconSystem;

    switch (iconSystem) {
      case IconSystem.material:
        return buildMaterialIcon(context);
      case IconSystem.cupertino:
        return buildCupertinoIcon(context);
      case IconSystem.fluent:
        return buildFluentIcon(context);
      case IconSystem.macos:
        return buildMacosIcon(context);
      case IconSystem.fontAwesome:
        return buildFontAwesomeIcon(context);
      case IconSystem.yaru:
        return buildYaruIcon(context);
    }
  }
}
