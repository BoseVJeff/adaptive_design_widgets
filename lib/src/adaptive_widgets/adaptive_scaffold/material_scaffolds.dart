import 'package:flutter/material.dart';

class MaterialExpandedScaffold extends StatelessWidget {
  const MaterialExpandedScaffold({
    super.key,
    this.appBar,
    this.body,
    required this.currentIndex,
    this.onSelected,
    required this.destinations,
  });

  final PreferredSizeWidget? appBar;

  final int currentIndex;

  final void Function(int)? onSelected;

  final List<NavigationDrawerDestination> destinations;

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: NavigationDrawer(
        selectedIndex: currentIndex,
        onDestinationSelected: onSelected,
        children: destinations,
      ),
      body: body,
    );
  }
}

class MaterialCompactScaffold extends StatelessWidget {
  const MaterialCompactScaffold({
    super.key,
    this.appBar,
    this.body,
    required this.currentIndex,
    this.onSelected,
    required this.destinations,
  });

  final PreferredSizeWidget? appBar;

  final int currentIndex;

  final void Function(int)? onSelected;

  final List<NavigationDestination> destinations;

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onSelected,
        destinations: destinations,
      ),
    );
  }
}
