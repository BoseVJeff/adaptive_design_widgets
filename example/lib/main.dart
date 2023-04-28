import 'package:adaptive_design_widgets/adaptive_design_widgets.dart';
import 'package:adaptive_design_widgets/widgets/adaptive_secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    /* ChangeNotifierProvider(
      create: (context) => DesignSystemProvider(),
      child: const MainApp(),
    ), */
    const MainApp(),
  );
}

final List<GoRoute> routes = [
  GoRoute(
    path: '/',
    builder: (_, __) => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: material.Colors.red,
        ),
      ),
      /* child: Text(
          'Route /, Page 1',
          style: TextStyle(
            backgroundColor: material.Colors.green,
          ),
        ), */
      child: const AdaptiveListTile(
        title: Text('Page 1'),
        subTitle: Text('Route /'),
        leading: Icon(material.Icons.abc),
      ),
    ),
  ),
  GoRoute(
    path: '/abc',
    builder: (_, __) => const Center(
      /* child: Text(
          'Route /, Page abc',
          style: TextStyle(
            backgroundColor: material.Colors.green,
          ),
        ), */
      child: AdaptiveListTile(
        title: Text('Page 2'),
        subTitle: Text('Route /abc'),
        leading: Icon(material.Icons.abc),
      ),
    ),
  ),
  GoRoute(
    path: '/qwerty',
    builder: (_, __) => const QwertyPathWidget(),
  ),
];

final GoRouter router = GoRouter(
  initialLocation: '/abc',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(
          child: child,
        );
      },
      routes: routes,
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DesignSystemProvider(),
      child: AdaptiveApp(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        color: const Color.fromRGBO(0, 0, 255, 1.0),
        themeMode: AdaptiveThemeMode.system,
        theme: AdaptiveThemeData.light(),
        darkTheme: AdaptiveThemeData.dark(),
        useDynamicTheme: false,
      ),
    );
  }
}

class QwertyPathWidget extends material.StatelessWidget {
  const QwertyPathWidget({
    super.key,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return Center(
      child: Column(
        children: [
          const AdaptiveListTile(
            title: Text('Page 3'),
            subTitle: Text('Route /qwerty'),
            leading: Icon(material.Icons.abc),
          ),
          const AdaptiveTextField(
            placeholder: 'Sample Text Field',
            prefix: Icon(material.Icons.search),
            suffix: Icon(material.Icons.clear),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              AdaptivePrimaryButton(
                child: const Text('Material'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.material);
                },
              ),
              AdaptivePrimaryButton(
                child: const Text('Cupertino'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.cupertino);
                },
              ),
              AdaptivePrimaryButton(
                child: const Text('Fluent'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.fluent);
                },
              ),
              AdaptivePrimaryButton(
                child: const Text('MacOS'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.macos);
                },
              ),
              AdaptivePrimaryButton(
                child: const Text('Yaru'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.yaru);
                },
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              AdaptiveSecondaryButton(
                child: const Text('Material'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.material);
                },
              ),
              AdaptiveSecondaryButton(
                child: const Text('Cupertino'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.cupertino);
                },
              ),
              AdaptiveSecondaryButton(
                child: const Text('Fluent'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.fluent);
                },
              ),
              AdaptiveSecondaryButton(
                child: const Text('MacOS'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.macos);
                },
              ),
              AdaptiveSecondaryButton(
                child: const Text('Yaru'),
                onPressed: () {
                  Provider.of<DesignSystemProvider>(
                    context,
                    listen: false,
                  ).setDesignSystem(DesignSystem.yaru);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late String location;
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    location = GoRouter.of(context).location;
    switch (location) {
      case '/':
        currentIndex = 0;
        break;
      case '/abc':
        currentIndex = 1;
        break;
      case '/qwerty':
        currentIndex = 2;
        break;
      default:
        currentIndex = 0;
        break;
    }
  }

  void _onSelected(int? index) {
    if (index == null) {
      return;
    }
    String nextRoute;
    switch (index) {
      case 0:
        nextRoute = '/';
        break;
      case 1:
        nextRoute = '/abc';
        break;
      case 2:
        nextRoute = '/qwerty';
        break;
      default:
        nextRoute = '/';
        break;
    }
    setState(() {
      currentIndex = index;
    });
    GoRouter.of(context).push(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      currentIndex: currentIndex,
      onSelected: _onSelected,
      navigationItems: const [
        AdaptiveNavigationItem(
          icon: Icon(material.Icons.home),
          label: 'Home',
        ),
        AdaptiveNavigationItem(
          icon: Icon(material.Icons.abc),
          label: 'abc',
        ),
        AdaptiveNavigationItem(
          icon: Icon(material.Icons.qr_code),
          label: 'qwerty',
        ),
      ],
      body: widget.child,
      title: Text(location),
    );
  }
}
