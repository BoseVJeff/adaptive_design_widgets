import 'package:adaptive_design_widgets/design_system_provider.dart';
import 'package:adaptive_design_widgets/design_systems.dart';
import 'package:adaptive_design_widgets/widgets/adaptive_theme.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:provider/provider.dart';
import 'package:yaru/yaru.dart' as yaru;
import 'package:chicago/chicago.dart' as chicago;
import 'package:dynamic_color/dynamic_color.dart' as dynamic_color;

// TODO: Revert this back to extending [AdaptiveWidgetInterface] and constrain all shenanigans to a custom [ThemeAwareCupertinoWidget] instead
class AdaptiveApp extends StatefulWidget {
  const AdaptiveApp({
    super.key,
    required this.routeInformationParser,
    required this.routerDelegate,
    required this.color,
    this.routeInformationProvider,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.themeMode = AdaptiveThemeMode.system,
    this.useDynamicTheme = false,
  });

  final RouteInformationParser<Object> routeInformationParser;
  final RouterDelegate<Object> routerDelegate;
  final RouteInformationProvider? routeInformationProvider;
  // Not supported in macos_ui and fluent_design
  // final RouterConfig<Object> routerConfig;
  final Color color;
  final String title;
  final AdaptiveThemeData? theme;
  // HACK: Look into having a better manual theme switching setup for [CupertinoApp]
  final AdaptiveThemeData? darkTheme;
  final AdaptiveThemeMode themeMode;

  final bool useDynamicTheme;

  @override
  State<AdaptiveApp> createState() => _AdaptiveAppState();
}

class _AdaptiveAppState
    extends State<AdaptiveApp> /* with WidgetsBindingObserver */ {
  late Brightness _cupertinoBrightness;
  // Used by material, macos, yaru
  late material.ThemeMode _materialThemeMode;
  late fluent.ThemeMode _fluentThemeMode;

  void _updateThemeModes() {
    switch (widget.themeMode) {
      case AdaptiveThemeMode.light:
        _materialThemeMode = material.ThemeMode.light;
        _cupertinoBrightness = Brightness.light;
        _fluentThemeMode = fluent.ThemeMode.light;
        break;
      case AdaptiveThemeMode.dark:
        _materialThemeMode = material.ThemeMode.dark;
        _cupertinoBrightness = Brightness.dark;
        _fluentThemeMode = fluent.ThemeMode.dark;
        break;
      case AdaptiveThemeMode.system:
        _materialThemeMode = material.ThemeMode.system;
        _fluentThemeMode = fluent.ThemeMode.system;
        _cupertinoBrightness =
            WidgetsBinding.instance.window.platformBrightness;
        break;
    }
  }

  @override
  void didUpdateWidget(covariant AdaptiveApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(_updateThemeModes);
  }

  @override
  void initState() {
    super.initState();
    _updateThemeModes();
    // Register listner for cases where the system theme changes without a widget update.
    // This is the expected behaviour when AdaptiveThemeMode is ThemeMode.system.
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      if (widget.themeMode == AdaptiveThemeMode.system) {
        setState(() {
          _cupertinoBrightness = _cupertinoBrightness =
              WidgetsBinding.instance.window.platformBrightness;
          // ui.PlatformDispatcher.instance.onpla
        });
      }
    };
  }

  /* @override
  void didChangePlatformBrightness() {
    // if (widget.themeMode == AdaptiveThemeMode.system) {
    setState(() {
      _cupertinoBrightness = _cupertinoBrightness =
          WidgetsBinding.instance.window.platformBrightness;
          // ui.PlatformDispatcher.instance.onpla
    });
    // }
  } */

  Widget buildCupertinoWidget(BuildContext context) {
    // final systemBrightness = MediaQuery.platformBrightnessOf(context);
    // ui.PlatformDispatcher.instance.onPlatformBrightnessChanged=() {};
    // WidgetsBindingObserver().didChangePlatformBrightness();
    // WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged=() {};

    return cupertino.CupertinoApp.router(
      routeInformationParser: widget.routeInformationParser,
      routerDelegate: widget.routerDelegate,
      routeInformationProvider: widget.routeInformationProvider,
      color: widget.color,
      title: widget.title,
      theme: (_cupertinoBrightness == Brightness.light)
          ? widget.theme?.cupertinoThemeData
          : widget.darkTheme?.cupertinoThemeData,
      /* theme: const cupertino.CupertinoThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      ), */
    );
  }

  Widget buildFluentWidget(BuildContext context) {
    // TODO: Look into using the `system_theme` package by the same author to get the system accent color
    // Current concerns are regarding clarity on how the highlight color is determined on the Web
    // Sepcifically, in the below mentioned line, what is the `'highlight'` color used. No information regarding this seems to be available.
    // Line: https://github.com/bdlukaa/system_theme/blob/ead8d79fc8a7632b29a76aec7b6061cb60bd6891/system_theme_web/lib/system_theme_web.dart#L30
    return fluent.FluentApp.router(
      routeInformationParser: widget.routeInformationParser,
      routerDelegate: widget.routerDelegate,
      routeInformationProvider: widget.routeInformationProvider,
      color: widget.color,
      title: widget.title,
      theme: widget.theme?.fluentThemeData,
      darkTheme: widget.darkTheme?.fluentThemeData,
      themeMode: _fluentThemeMode,
    );
  }

  Widget buildMacosWidget(BuildContext context) {
    // There seems to be no recomendation on how to use system accents for this package.
    return macos.MacosApp.router(
      routeInformationParser: widget.routeInformationParser,
      routerDelegate: widget.routerDelegate,
      routeInformationProvider: widget.routeInformationProvider,
      color: widget.color,
      title: widget.title,
      theme: widget.theme?.macosThemeData,
      darkTheme: widget.darkTheme?.macosThemeData,
      themeMode: _materialThemeMode,
    );
  }

  Widget buildMaterialWidget(BuildContext context) {
    return dynamic_color.DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
      return material.MaterialApp.router(
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        routeInformationProvider: widget.routeInformationProvider,
        color: widget.color,
        title: widget.title,
        theme: (widget.useDynamicTheme)
            ? material.ThemeData.from(
                colorScheme: lightDynamic ?? const material.ColorScheme.light(),
              )
            : widget.theme?.materialThemeData,
        darkTheme: (widget.useDynamicTheme)
            ? material.ThemeData.from(
                colorScheme: darkDynamic ?? const material.ColorScheme.dark(),
              )
            : widget.darkTheme?.materialThemeData,
        themeMode: _materialThemeMode,
      );
    });
  }

  Widget buildYaruWidget(BuildContext context) {
    return yaru.YaruTheme(builder: (context, yaruThemeData, child) {
      return material.MaterialApp.router(
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        routeInformationProvider: widget.routeInformationProvider,
        color: widget.color,
        title: widget.title,
        theme: (widget.useDynamicTheme)
            ? yaruThemeData.theme
            : widget.theme?.yaruThemeData,
        darkTheme: (widget.useDynamicTheme)
            ? yaruThemeData.darkTheme
            : widget.darkTheme?.yaruThemeData,
        themeMode: _materialThemeMode,
      );
    });
  }

  /* Widget buildChicagoWidget(BuildContext context) {
    return chicago.ChicagoApp(
      title: widget.title,
      home: WidgetsApp.router(
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        routeInformationProvider: widget.routeInformationProvider,
        color: widget.color,
        title: widget.title,
      ),
    );
  } */

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
      case DesignSystem.yaru:
        return buildYaruWidget(context);
      /* case DesignSystem.chicago:
        return buildChicagoWidget(context); */
    }
  }
}
