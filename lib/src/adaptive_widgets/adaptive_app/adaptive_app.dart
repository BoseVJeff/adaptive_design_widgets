import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru/yaru.dart' as yaru;

class AdaptiveApp extends AdaptiveWidgetInterface {
  // All assertions, etc copied wholesale from the [WidgetsApp] implementation.
  AdaptiveApp({
    // can't be const because the asserts use methods on Iterable :-(
    super.key,
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
        // Assertion to make sure that the conversion to LogicalKeySet for MacosApp stays valid
        assert(shortcuts == null ||
            shortcuts.keys.every((element) => element.triggers != null)),
        routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null,
        _isRouter = false;

  AdaptiveApp.router({
    super.key,
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
        // Assertion to make sure that the conversion to LogicalKeySet for MacosApp stays valid
        assert(shortcuts == null ||
            shortcuts.keys.every((element) => element.triggers != null)),
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

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return cupertino.CupertinoApp(
        actions: actions,
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
        shortcuts: shortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        // theme: ,
        title: title,
      );
    } else {
      return cupertino.CupertinoApp.router(
        actions: actions,
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
        shortcuts: shortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        // theme: ,
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
        // darkTheme: darkTheme,
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
        // theme: ,
        // themeMode: ,
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
        // darkTheme: ,
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
        // theme: ,
        // themeMode: ,
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
        // darkTheme: darkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: debugShowM,
        // highContrastDarkTheme: this.highContrastDarkTheme,
        // highContrastTheme: ,
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
        // scaffoldMessengerKey: sca,
        // scrollBehavior: ,
        // TODO: Convert 'Map<ShortcutActivator, Intent>?' to 'Map<LogicalKeySet, Intent>?'.
        // shortcuts: shortcuts,
        shortcuts: (shortcuts ?? WidgetsApp.defaultShortcuts)
            .map<LogicalKeySet, Intent>((key, value) =>
                MapEntry(LogicalKeySet.fromSet(key.triggers!.toSet()), value)),
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        // theme: ,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        // themeMode: ,
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
        // darkTheme: ,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: ,
        // highContrastDarkTheme: ,
        // highContrastTheme: ,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        onGenerateTitle: onGenerateTitle,
        restorationScopeId: restorationScopeId,
        // Adding null check here as this is asserted by the constructor
        routeInformationParser: routeInformationParser!,
        routeInformationProvider: routeInformationProvider,
        // routerConfig: routerConfig,
        // Adding null check here as this is asserted by the constructor
        routerDelegate: routerDelegate!,
        // scaffoldMessengerKey: ,
        // scrollBehavior: ,
        shortcuts: (shortcuts ?? WidgetsApp.defaultShortcuts)
            .map<LogicalKeySet, Intent>((key, value) =>
                MapEntry(LogicalKeySet.fromSet(key.triggers!.toSet()), value)),
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        // theme: ,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        // themeMode: ,
        title: title,
      );
    }
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    if (!_isRouter) {
      return material.MaterialApp(
        actions: actions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        // darkTheme: darkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: debugShowM,
        // highContrastDarkTheme: this.highContrastDarkTheme,
        // highContrastTheme: ,
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
        shortcuts: shortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        // theme: ,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        // themeMode: ,
        title: title,
      );
    } else {
      return material.MaterialApp.router(
        actions: actions,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        // darkTheme: ,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: ,
        // highContrastDarkTheme: ,
        // highContrastTheme: ,
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
        shortcuts: shortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        // theme: ,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        // themeMode: ,
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
        // darkTheme: darkTheme,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: debugShowM,
        // highContrastDarkTheme: this.highContrastDarkTheme,
        // highContrastTheme: ,
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
        // theme: ,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        // themeMode: ,
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
        // darkTheme: ,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        // debugShowMaterialGrid: ,
        // highContrastDarkTheme: ,
        // highContrastTheme: ,
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
        // theme: ,
        // themeAnimationCurve: ,
        // themeAnimationDuration: ,
        // themeMode: ,
        title: title,
      );
    }
  }
}
