import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart' as material;
import 'package:yaru_widgets/yaru_widgets.dart' as yaru;

class YaruExpandedScaffold extends StatelessWidget {
  const YaruExpandedScaffold({
    super.key,
    required this.child,
    this.title,
    required this.currentIndex,
    this.onSelected,
    required this.length,
    required this.masterTileBuilder,
  });

  final Widget? title;

  final int currentIndex;

  final void Function(int?)? onSelected;

  final int length;

  final yaru.YaruMasterTile Function(BuildContext, int index, bool selected)
      masterTileBuilder;

  final Widget Function(BuildContext, int index) child;

  @override
  Widget build(BuildContext context) {
    return yaru.YaruMasterDetailPage(
      appBar: yaru.YaruWindowTitleBar(
        title: title,
      ),
      initialIndex: currentIndex,
      length: length,
      onSelected: onSelected,
      tileBuilder: masterTileBuilder,
      pageBuilder: child,
    );
  }
}

class YaruCompactScaffold extends StatelessWidget {
  const YaruCompactScaffold({
    super.key,
    required this.child,
    this.title,
    required this.currentIndex,
    this.onSelected,
    required this.length,
    required this.navigationRailItemBuilder,
  });

  final Widget? title;

  final int currentIndex;

  final void Function(int?)? onSelected;

  final int length;

  final yaru.YaruNavigationRailItem Function(
      BuildContext, int index, bool selected) navigationRailItemBuilder;

  final Widget Function(BuildContext, int index) child;

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      appBar: yaru.YaruWindowTitleBar(
        title: title,
      ),
      body: yaru.YaruNavigationPage(
        length: length,
        initialIndex: currentIndex,
        onSelected: onSelected,
        itemBuilder: navigationRailItemBuilder,
        pageBuilder: (context, index) {
          return material.Scaffold(
            body: child(context, index),
          );
        },
      ),
    );
  }
}
