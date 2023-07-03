import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:adaptive_design_widgets/adaptive_design_widgets.dart';

// Make the following changes to the macos_ui package:
// File: C:\Users\jeffb\AppData\Local\Pub\Cache\hosted\pub.dev\macos_ui-1.12.2\lib\src\fields\text_field.dart
// Changes:
// 108:22 - TapUpDetails -> TapDragUpDetails
// 130:27 - DragEndDetails -> TapDragEndDetails

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Add a global navigator key to allow router state to persist accross changes in DesignSystem.
  static final GlobalKey<NavigatorState> globalKeyNavigator =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return DesignAncestor(
      initialDesignSystem: DesignSystem.macos,
      child: AdaptiveApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: globalKeyNavigator,
        title: 'Flutter Demo',
        color: material.Colors.blue.shade500,
        adaptiveTheme: AdaptiveTheme.defaultTheme,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        builder: (context, child) => Container(
          child: child,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      compactMode: true,
      title: Text(widget.title),
      /* appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ), */
      currentIndex: _currentPageIndex,
      childBuilder: (_, int index) {
        if (index == 1) {
          return const SettingsPage();
        } else {
          return const HomePage();
        }
      },
      navigationItems: [
        AdaptiveNavigationItem(
          icon: AdaptiveIcon.designIcon(),
          label: 'Home Page',
        ),
        AdaptiveNavigationItem(
          icon: AdaptiveIcon.designIcon(color: const Color(0xFF00FF00)),
          label: 'Settings Page',
        ),
      ],
      onSelected: (int? index) {
        if (index != null) {
          setState(() {
            _currentPageIndex = index;
          });
        }
      },
    );
  }
}

class HomePage extends material.StatefulWidget {
  const HomePage({super.key});

  @override
  material.State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends material.State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have pressed the button this many times.'),
          Text('$_counter'),
          AdaptiveIconutton(
            onPressed: _incrementCounter,
            icon: AdaptiveIcon.designIcon(),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: List<AdaptiveIconutton>.generate(
          DesignSystem.values.length,
          (index) => AdaptiveIconutton(
            onPressed: () => DesignAncestor.setDesignSystemOf(
              context,
              DesignSystem.values[index],
            ),
            icon: Text(DesignSystem.values[index].name),
            tooltip: DesignSystem.values[index].name,
          ),
        ),
      ),
    );
  }
}
