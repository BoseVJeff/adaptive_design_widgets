import 'package:adaptive_design_widgets/design_system_provider.dart';
import 'package:adaptive_design_widgets/design_systems.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class AdaptiveWidgetInterface extends StatelessWidget {
  const AdaptiveWidgetInterface({super.key});

  /// Widget for Material Design v2 or v3.
  ///
  /// This should ideally be used in a MaterialApp with ThemeData.useMaterial3=true or equivalent.
  Widget buildMaterialWidget(BuildContext context);

  /// Widget for Cupertino (iOS) design
  ///
  /// This should ideally be used in a CupertinoApp
  Widget buildCupertinoWidget(BuildContext context);

  /// Widget for Fluent (Microsoft) design
  ///
  /// This should ideally be used in a FluentApp from fluent_ui
  Widget buildFluentWidget(BuildContext context);

  /// Widget for MacOS UI design
  ///
  /// This should ideally be used in a CupertinoApp with macos_ui
  Widget buildMacosWidget(BuildContext context);

  /// Widget for Yaru design
  ///
  /// This is the design system used by Ubuntu desktop. This should ideally be used with yaru themes only
  Widget buildYaruWidget(BuildContext context);

  /// Widget for Chicago design
  ///
  /// This is the Win95 design. This should ideally be used in a ChicagoApp
  // Widget buildChicagoWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    DesignSystem designSystem =
        Provider.of<DesignSystemProvider>(context).designSystem;

    switch (designSystem) {
      case DesignSystem.material:
        return buildMaterialWidget(context);
      case DesignSystem.cupertino:
        return buildCupertinoWidget(context);
      case DesignSystem.fluent:
        return buildFluentWidget(context);
      case DesignSystem.macos:
        return buildMacosWidget(context);
      /* case DesignSystem.chicago:
        return buildChicagoWidget(context); */
      case DesignSystem.yaru:
        return buildYaruWidget(context);
    }
  }
}
