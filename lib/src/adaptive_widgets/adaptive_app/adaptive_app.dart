import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;

// TODO: Look into supporting dynamic app themes (dynamic_color, yaru).
// These themes require a parent builder function that must be ideally inserted above the *App widget.
/// A wrapper widget for an app that uses adaptive design.
///
/// This class returns a different widget based on what the value of the parent [DesignAncestor] is.
/// For more details on the exact choices, refer to [AdaptiveWidgetInterface], the class that this class extends.
///
/// This class is a thin wrapper over all of the related `*App` widgets like `MaterialApp`, etc.
/// It attempts to pass the arguments through to the constructor as-is wherever possible.
/// Exceptions will be noted wherever they exist.
///
/// For more information, refer to the corresponding [WidgetsApp] docs.
class AdaptiveApp extends AdaptiveWidgetInterface {
  // All assertions, etc copied wholesale from the [WidgetsApp] implementation.
  AdaptiveApp({
    // can't be const because the asserts use methods on Iterable :-(
    super.key,
    this.adaptiveTheme = const AdaptiveTheme(),
    this.themeMode = AdaptiveThemeMode.system,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.initialRoute,
    this.pageRouteBuilder,
    this.home,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.textStyle,
    required this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowWidgetInspector = false,
    this.debugShowCheckedModeBanner = true,
    this.inspectorSelectButtonBuilder,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  })  : assert(
          home == null || onGenerateInitialRoutes == null,
          'If onGenerateInitialRoutes is specified, the home argument will be '
          'redundant.',
        ),
        assert(
          home == null || !routes.containsKey(Navigator.defaultRouteName),
          'If the home property is specified, the routes table '
          'cannot include an entry for "/", since it would be redundant.',
        ),
        assert(
          builder != null ||
              home != null ||
              routes.containsKey(Navigator.defaultRouteName) ||
              onGenerateRoute != null ||
              onUnknownRoute != null,
          'Either the home property must be specified, '
          'or the routes table must include an entry for "/", '
          'or there must be on onGenerateRoute callback specified, '
          'or there must be an onUnknownRoute callback specified, '
          'or the builder property must be specified, '
          'because otherwise there is nothing to fall back on if the '
          'app is started with an intent that specifies an unknown route.',
        ),
        assert(
          (home != null ||
                  routes.isNotEmpty ||
                  onGenerateRoute != null ||
                  onUnknownRoute != null) ||
              (builder != null &&
                  navigatorKey == null &&
                  initialRoute == null &&
                  navigatorObservers.isEmpty),
          'If no route is provided using '
          'home, routes, onGenerateRoute, or onUnknownRoute, '
          'a non-null callback for the builder property must be provided, '
          'and the other navigator-related properties, '
          'navigatorKey, initialRoute, and navigatorObservers, '
          'must have their initial values '
          '(null, null, and the empty list, respectively).',
        ),
        assert(
          builder != null ||
              onGenerateRoute != null ||
              pageRouteBuilder != null,
          'If neither builder nor onGenerateRoute are provided, the '
          'pageRouteBuilder must be specified so that the default handler '
          'will know what kind of PageRoute transition to build.',
        ),
        assert(supportedLocales.isNotEmpty),
        routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null,
        _isRouter = false;

  AdaptiveApp.router({
    super.key,
    this.adaptiveTheme = const AdaptiveTheme(),
    this.themeMode = AdaptiveThemeMode.system,
    this.routeInformationProvider,
    required this.routeInformationParser,
    required this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.textStyle,
    required this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowWidgetInspector = false,
    this.debugShowCheckedModeBanner = true,
    this.inspectorSelectButtonBuilder,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  })  : assert(() {
          if (routerConfig != null) {
            assert(
              (routeInformationProvider ??
                      routeInformationParser ??
                      routerDelegate ??
                      backButtonDispatcher) ==
                  null,
              'If the routerConfig is provided, all the other router delegates must not be provided',
            );
            return true;
          }
          assert(routerDelegate != null,
              'Either one of routerDelegate or routerConfig must be provided');
          assert(
            routeInformationProvider == null || routeInformationParser != null,
            'If routeInformationProvider is provided, routeInformationParser must also be provided',
          );
          return true;
        }()),
        assert(supportedLocales.isNotEmpty),
        // For MacosApp
        assert(routeInformationParser != null),
        // For MacosApp
        assert(routerDelegate != null),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        pageRouteBuilder = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        _isRouter = true;

  final bool _isRouter;

  /// The theme of this app.
  ///
  /// By default, this app delegates theming to the underlying widget.
  /// To have a stable default, set this to [AdaptiveTheme.defaultTheme] instead.
  ///
  /// This class includes both the light and dark variants of the theme.
  /// Additionally, high contrast variants can be provided for Material themes.
  ///
  /// This uses a custom class because all of the underlying themes are represented by seperate classes.
  final AdaptiveTheme adaptiveTheme;

  /// The theme mode of this app.
  ///
  /// By default, this value is [AdaptiveThemeMode.system].
  final AdaptiveThemeMode themeMode;

  final GlobalKey<NavigatorState>? navigatorKey;

  final RouteFactory? onGenerateRoute;

  final InitialRouteListFactory? onGenerateInitialRoutes;

  final PageRouteFactory? pageRouteBuilder;

  final RouteInformationParser<Object>? routeInformationParser;

  final RouterDelegate<Object>? routerDelegate;

  final BackButtonDispatcher? backButtonDispatcher;

  final RouteInformationProvider? routeInformationProvider;

  final RouterConfig<Object>? routerConfig;

  final Widget? home;

  final Map<String, WidgetBuilder>? routes;

  final RouteFactory? onUnknownRoute;

  final String? initialRoute;

  final List<NavigatorObserver>? navigatorObservers;

  final TransitionBuilder? builder;

  final String title;

  final GenerateAppTitle? onGenerateTitle;

  final TextStyle? textStyle;

  final Color color;

  final Locale? locale;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final LocaleListResolutionCallback? localeListResolutionCallback;

  final LocaleResolutionCallback? localeResolutionCallback;

  final Iterable<Locale> supportedLocales;

  final bool showPerformanceOverlay;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  final bool showSemanticsDebugger;

  final bool debugShowWidgetInspector;

  final InspectorSelectButtonBuilder? inspectorSelectButtonBuilder;

  final bool debugShowCheckedModeBanner;

  final Map<ShortcutActivator, Intent>? shortcuts;

  final Map<Type, Action<Intent>>? actions;

  final String? restorationScopeId;

  static bool showPerformanceOverlayOverride = false;

  static bool debugShowWidgetInspectorOverride = false;

  static bool debugAllowBannerOverride = true;

  // TODO: Look into light/dark theme switching for CupertinoApp.
  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return cupertino.CupertinoApp(
        actions: actions ?? WidgetsApp.defaultActions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        home: home,
        initialRoute: initialRoute,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        navigatorKey: navigatorKey,
        // This is the default value in the lib itself.
        navigatorObservers: navigatorObservers ?? const <NavigatorObserver>[],
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: onGenerateTitle,
        onUnknownRoute: onUnknownRoute,
        restorationScopeId: restorationScopeId,
        routes: routes ?? const <String, WidgetBuilder>{},
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.cupertinoTheme,
        title: title,
      );
    } else {
      return cupertino.CupertinoApp.router(
        actions: actions ?? WidgetsApp.defaultActions,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: onGenerateTitle,
        restorationScopeId: restorationScopeId,
        routeInformationParser: routeInformationParser,
        routeInformationProvider: routeInformationProvider,
        routerConfig: routerConfig,
        routerDelegate: routerDelegate,
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.cupertinoTheme,
        title: title,
      );
    }
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return fluent.FluentApp(
        actions: actions ?? WidgetsApp.defaultActions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.fluentDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        home: home,
        initialRoute: initialRoute,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        navigatorKey: navigatorKey,
        // This is the default value in the lib itself.
        navigatorObservers: navigatorObservers ?? const <NavigatorObserver>[],
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: onGenerateTitle,
        onUnknownRoute: onUnknownRoute,
        restorationScopeId: restorationScopeId,
        routes: routes ?? const <String, WidgetBuilder>{},
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.fluentTheme,
        themeMode: themeMode.fluentThemeMode,
        title: title,
      );
    } else {
      return fluent.FluentApp.router(
        actions: actions ?? WidgetsApp.defaultActions,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.fluentDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: onGenerateTitle,
        restorationScopeId: restorationScopeId,
        routeInformationParser: routeInformationParser,
        routeInformationProvider: routeInformationProvider,
        routerConfig: routerConfig,
        routerDelegate: routerDelegate,
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.fluentTheme,
        themeMode: themeMode.fluentThemeMode,
        title: title,
      );
    }
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return macos.MacosApp(
        actions: actions ?? WidgetsApp.defaultActions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.macosDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        home: home,
        initialRoute: initialRoute,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        navigatorKey: navigatorKey,
        // This is the default value in the lib itself.
        navigatorObservers: navigatorObservers ?? [],
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: onGenerateTitle,
        onUnknownRoute: onUnknownRoute,
        restorationScopeId: restorationScopeId,
        routes: routes ?? const <String, WidgetBuilder>{},
        // Converting 'Map<ShortcutActivator, Intent>?' to 'Map<LogicalKeySet, Intent>?'.
        shortcuts: (shortcuts ?? WidgetsApp.defaultShortcuts)
            .map<LogicalKeySet, Intent>(
          (key, value) => MapEntry(
              LogicalKeySet.fromSet(key.triggers?.toSet() ?? {}), value),
        ),
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.macosTheme,
        themeMode: themeMode.materialThemeMode,
        title: title,
      );
    } else {
      return macos.MacosApp.router(
        actions: actions ?? WidgetsApp.defaultActions,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.macosDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: onGenerateTitle,
        restorationScopeId: restorationScopeId,
        // Adding null check here as this is asserted by the constructor
        routeInformationParser: routeInformationParser!,
        routeInformationProvider: routeInformationProvider,
        // Adding null check here as this is asserted by the constructor
        routerDelegate: routerDelegate!,
        // scrollBehavior: ,
        shortcuts: (shortcuts ?? WidgetsApp.defaultShortcuts)
            .map<LogicalKeySet, Intent>(
          (key, value) => MapEntry(
              LogicalKeySet.fromSet(key.triggers?.toSet() ?? {}), value),
        ),
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.macosTheme,
        themeMode: themeMode.materialThemeMode,
        title: title,
      );
    }
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return material.MaterialApp(
        actions: actions ?? WidgetsApp.defaultActions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.materialDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: debugShowM,
        highContrastDarkTheme: adaptiveTheme.materialHighContrastDarkTheme,
        highContrastTheme: adaptiveTheme.materialHighContrastLightTheme,
        home: home,
        initialRoute: initialRoute,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        navigatorKey: navigatorKey,
        // This is the default value in the lib itself.
        navigatorObservers: navigatorObservers ?? const <NavigatorObserver>[],
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: onGenerateTitle,
        onUnknownRoute: onUnknownRoute,
        restorationScopeId: restorationScopeId,
        routes: routes ?? const <String, WidgetBuilder>{},
        // scaffoldMessengerKey: sca,
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.materialLightTheme,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        themeMode: themeMode.materialThemeMode,
        title: title,
      );
    } else {
      return material.MaterialApp.router(
        actions: actions ?? WidgetsApp.defaultActions,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.materialDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: ,
        highContrastDarkTheme: adaptiveTheme.materialHighContrastDarkTheme,
        highContrastTheme: adaptiveTheme.materialHighContrastLightTheme,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: onGenerateTitle,
        restorationScopeId: restorationScopeId,
        routeInformationParser: routeInformationParser,
        routeInformationProvider: routeInformationProvider,
        routerConfig: routerConfig,
        routerDelegate: routerDelegate,
        // scaffoldMessengerKey: ,
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.materialLightTheme,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        themeMode: themeMode.materialThemeMode,
        title: title,
      );
    }
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return material.MaterialApp(
        actions: actions ?? WidgetsApp.defaultActions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.yaruDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        highContrastTheme: adaptiveTheme.yaruHighContrastLightTheme,
        highContrastDarkTheme: adaptiveTheme.yaruHighContrastDarkTheme,
        home: home,
        initialRoute: initialRoute,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        navigatorKey: navigatorKey,
        // This is the default value in the lib itself.
        navigatorObservers: navigatorObservers ?? const <NavigatorObserver>[],
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: onGenerateTitle,
        onUnknownRoute: onUnknownRoute,
        restorationScopeId: restorationScopeId,
        routes: routes ?? const <String, WidgetBuilder>{},
        // scaffoldMessengerKey: sca,
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.yaruTheme,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        themeMode: themeMode.materialThemeMode,
        title: title,
      );
    } else {
      return material.MaterialApp.router(
        actions: actions ?? WidgetsApp.defaultActions,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        darkTheme: adaptiveTheme.yaruDarkTheme ??
            AdaptiveTheme.defaultTheme.yaruDarkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        highContrastTheme: adaptiveTheme.yaruHighContrastLightTheme,
        highContrastDarkTheme: adaptiveTheme.yaruHighContrastDarkTheme,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: onGenerateTitle,
        restorationScopeId: restorationScopeId,
        routeInformationParser: routeInformationParser,
        routeInformationProvider: routeInformationProvider,
        routerConfig: routerConfig,
        routerDelegate: routerDelegate,
        // scaffoldMessengerKey: ,
        // scrollBehavior: ,
        shortcuts: shortcuts ?? WidgetsApp.defaultShortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        theme: adaptiveTheme.yaruTheme ?? AdaptiveTheme.defaultTheme.yaruTheme,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        themeMode: themeMode.materialThemeMode,
        title: title,
      );
    }
  }
}
