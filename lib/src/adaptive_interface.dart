import 'package:adaptive_design_widgets/adaptive_design_widgets.dart';
import 'package:flutter/widgets.dart';

typedef AdaptiveIconImplementation = Widget Function({
  double? size,
  double? fill,
  double? weight,
  double? grade,
  double? opticalSize,
  Color? color,
  List<Shadow>? shadows,
  String? semanticLabel,
  TextDirection? textDirection,
});

/// Abstract interface for an Adaptive widget. Depends on [DesignSystem].
///
/// Use this for all widgets that are NOT icons. For icons, use [AdaptiveIconInterface].
abstract interface class AdaptiveWidgetInterface extends StatelessWidget {
  const AdaptiveWidgetInterface({super.key});

  Widget materialWidgetBuilder(BuildContext context);

  Widget cupertinoWidgetBuilder(BuildContext context);

  Widget fluentWidgetBuilder(BuildContext context);

  Widget macosWidgetBuilder(BuildContext context);

  Widget yaruWidgetBuilder(BuildContext context);

  Widget _getBuilderFromDesignSystem(
    BuildContext context,
    DesignSystem designSystem,
  ) {
    switch (designSystem) {
      case DesignSystem.material:
        return materialWidgetBuilder(context);
      case DesignSystem.cupertino:
        return cupertinoWidgetBuilder(context);
      case DesignSystem.fluent:
        return fluentWidgetBuilder(context);
      case DesignSystem.macos:
        return macosWidgetBuilder(context);
      case DesignSystem.yaru:
        return yaruWidgetBuilder(context);
      case DesignSystem.platform:
        return _getBuilderFromDesignSystem(
          context,
          DesignSystem.platformDesignSystem(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DesignAncestor.designSystemNotifierOf(context),
      builder: (context, designSystem, _) {
        return _getBuilderFromDesignSystem(context, designSystem);
      },
    );
  }
}

/// Abstract interface for an Adaptive icon. Depends on [IconSystem].
///
/// Use this for ONLY icons. For other widgets, use [AdaptiveWidgetInterface].
///
/// The type of each icon is [Widget] as not all icon systems use the [Icon] class as the container.
/// For example, `macos_ui` uses [MacosIcon] as the wrapper over [CupertinoIcon].
abstract interface class AdaptiveIconInterface extends StatelessWidget {
  const AdaptiveIconInterface({
    super.key,
    this.fill,
    this.size,
    this.weight,
    this.grade,
    this.opticalSize,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
  });

  final double? fill;
  final double? size;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final Color? color;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;

  Widget materialIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget materialSymbolsIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget cupertinoIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget fluentIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget macosIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget msFluentIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget yaruIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });
  Widget fontAwesomeIcon({
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DesignAncestor.iconsSystemNotifierOf(context),
      builder: (_, value, __) {
        switch (value) {
          case IconSystem.cupertinoIcons:
            return cupertinoIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.fluentIcons:
            return fluentIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.fontAwesomeIcons:
            return fontAwesomeIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.macosIcons:
            return macosIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.materialIcons:
            return materialIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.materialSymbols:
            return materialSymbolsIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.msFluentIcons:
            return msFluentIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.yaruIcons:
            return yaruIcon(
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            );
          case IconSystem.defaultIcons:
            return _DefaultIcons(
              cupertinoImpl: cupertinoIcon,
              fluentImpl: msFluentIcon,
              macosImpl: macosIcon,
              materialImpl: materialIcon,
              yaruImpl: yaruIcon,
            );
        }
      },
    );
  }
}

/// Abstract interface for an Adaptive object. Depends on [DesignSystem].
///
/// This class will always attempt to resolve to a particular design system. To have a different behaviour for the default/platform case, implement a method from scratch.
///
/// The platform case, [DesignSystem.platform] is handled by default using [DesignSystem.platformDesignSystem]. To change this behaviour, override [AdaptiveDesignObjectInterface.getPlatformDesignSystem] with your desired method.
///
/// Use this for miscellaneous objects that are are not widgets. Examples would be [ThemeData], etc.
/// For icons, use [AdaptiveIconInterface]. For widgets, use [AdaptiveWidgetInterface].
abstract interface class AdaptiveDesignObjectInterface<T> {
  T materialDesignObjectBuilder();

  T cupertinoDesignObjectBuilder();

  T fluentDesignObjectBuilder();

  T macosDesignObjectBuilder();

  T yaruDesignObjectBuilder();

  DesignSystem getPlatformDesignSystem() => DesignSystem.platformDesignSystem();

  T adaptiveDesignObjectWith(DesignSystem designSystem) {
    switch (designSystem) {
      case DesignSystem.material:
        return materialDesignObjectBuilder();
      case DesignSystem.cupertino:
        return cupertinoDesignObjectBuilder();
      case DesignSystem.fluent:
        return fluentDesignObjectBuilder();
      case DesignSystem.macos:
        return macosDesignObjectBuilder();
      case DesignSystem.yaru:
        return yaruDesignObjectBuilder();
      case DesignSystem.platform:
        return adaptiveDesignObjectWith(getPlatformDesignSystem());
    }
  }

  T adaptiveDesignObjectOf(BuildContext context) {
    return adaptiveDesignObjectWith(DesignAncestor.designSystemOf(context));
  }
}

class _DefaultIcons extends AdaptiveWidgetInterface {
  const _DefaultIcons({
    required this.cupertinoImpl,
    required this.fluentImpl,
    required this.macosImpl,
    required this.materialImpl,
    required this.yaruImpl,
  });

  final AdaptiveIconImplementation cupertinoImpl;

  final AdaptiveIconImplementation fluentImpl;

  final AdaptiveIconImplementation macosImpl;

  final AdaptiveIconImplementation materialImpl;

  final AdaptiveIconImplementation yaruImpl;

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    return cupertinoImpl();
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    return fluentImpl();
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    return macosImpl();
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    return materialImpl();
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) {
    return yaruImpl();
  }
}
