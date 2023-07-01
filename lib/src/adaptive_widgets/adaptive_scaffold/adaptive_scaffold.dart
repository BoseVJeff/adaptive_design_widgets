import 'package:adaptive_design_widgets/src/adaptive_interface.dart';
import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_scaffold/adaptive_navigation_item.dart';
import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_scaffold/material_scaffolds.dart';
import 'package:adaptive_design_widgets/src/adaptive_widgets/adaptive_scaffold/yaru_scaffolds.dart';

import 'package:adaptive_design_widgets/src/consts/design_system.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:yaru_widgets/widgets.dart';
// import 'package:yaru/yaru.dart' as yaru;
import 'package:yaru_widgets/yaru_widgets.dart' as yaru;

class AdaptiveScaffold extends AdaptiveWidgetInterface {
  const AdaptiveScaffold({
    super.key,
    this.compactMode = false,
    this.currentIndex = 0,
    required this.onSelected,
    this.title,
    required this.navigationItems,
    required this.childBuilder,
  });

  /// Whether to use compact mode or not.
  ///
  /// Currently, this only affects [DesignSystem.yaru].
  /// [compactMode]==true results in a [material.Scaffold] being used instead of [yaru.YaruMasterDetailPage].
  final bool compactMode;

  /// Index of the currently selected [AdaptiveNavigationItem].
  ///
  /// This value should be less than [navigationItems].length.
  final int currentIndex;

  /// When an index is selected
  ///
  /// Index is nullable in Yaru
  final void Function(int?) onSelected;

  /// The current title
  ///
  /// On iOS, this is placed in the middle of the [cupertino.CupertinoNavigationBar].
  ///
  /// On Fluent, this is placed in a [fluent.NavigationAppBar].
  ///
  /// On MacOS, this is placed in the [macos.TitleBar].
  ///
  /// On material, this is placed in the [material.AppBar].
  ///
  /// On Yaru, this is placed in a [yaru.YaruWindowTitleBar].
  final Widget? title;

  /// The main body content of the scaffold.
  final Widget Function(BuildContext, int index) childBuilder;

  /// The items in the menu.
  ///
  /// Since the scaffold can layout a bottom navigation bar under certain circumstances, consider limiting this to four or less items
  final List<AdaptiveNavigationItem> navigationItems;

  @override
  Widget cupertinoWidgetBuilder(BuildContext context) {
    /* return cupertino.CupertinoPageScaffold(
      navigationBar: cupertino.CupertinoNavigationBar(),
      child: child,
    ); */
    return cupertino.CupertinoTabScaffold(
      tabBar: cupertino.CupertinoTabBar(
        onTap: onSelected,
        currentIndex: currentIndex,
        items: navigationItems
            .map<cupertino.BottomNavigationBarItem>((e) => e.cupertinoItem())
            .toList(),
      ),
      tabBuilder: (context, index) {
        return cupertino.CupertinoPageScaffold(
          navigationBar: cupertino.CupertinoNavigationBar(
            middle: title,
          ),
          child: Builder(
            builder: (context) => childBuilder(context, index),
          ),
        );
      },
    );
  }

  @override
  Widget fluentWidgetBuilder(BuildContext context) {
    return fluent.NavigationView(
      appBar: fluent.NavigationAppBar(
        title: title,
      ),
      pane: fluent.NavigationPane(
        onChanged: onSelected,
        selected: currentIndex,
        items: navigationItems
            .map<fluent.NavigationPaneItem>((e) => e.fluentItem())
            .toList(),
      ),
      paneBodyBuilder: (item, body) {
        // HACK: This uses the global [currentIndex] state.
        return childBuilder(context, currentIndex);
      },
      // content is ignored because pane is provided.
      /* content: fluent.ScaffoldPage(
        content: Builder(
          builder: (context) => child(context, index),
        ),
      ), */
    );
  }

  @override
  Widget macosWidgetBuilder(BuildContext context) {
    return macos.MacosWindow(
      titleBar: macos.TitleBar(
        title: title,
      ),
      sidebar: macos.Sidebar(
        // minWidth taken from example
        // Source: https://macosui.dev/docs/getting_started/first_app
        minWidth: 200,
        builder: (context, scrollController) {
          return macos.SidebarItems(
            currentIndex: currentIndex,
            onChanged: onSelected,
            scrollController: scrollController,
            items: navigationItems
                .map<macos.SidebarItem>((e) => e.macosItem())
                .toList(),
          );
        },
      ),
      child: Builder(
        builder: (_) => macos.MacosScaffold(
          // toolBar: ,
          children: [
            macos.ContentArea(
              builder: (context, scrollController) {
                return childBuilder(context, currentIndex);
              },
            ),
            // One or more macos.ResizablePane
            // macos.ResizablePane(),
          ],
        ),
      ),
    );
  }

  @override
  Widget materialWidgetBuilder(BuildContext context) {
    /* return material.Scaffold(
      appBar: material.AppBar(),
      drawer: material.NavigationDrawer(
        selectedIndex: currentIndex,
        children: <material.NavigationDrawerDestination>[],
        onDestinationSelected: (int value) {},
      ),
      body: child,
    ); */
    // Respecting comapct mode using reference from example in docs.
    // Docs: https://api.flutter.dev/flutter/material/NavigationDrawer-class.html
    if (compactMode) {
      return MaterialExpandedScaffold(
        appBar: material.AppBar(
          title: title,
        ),
        currentIndex: currentIndex,
        onSelected: onSelected,
        destinations: navigationItems
            .map<material.NavigationDrawerDestination>(
                (e) => e.materialDrawerItem())
            .toList(),
        body: childBuilder(context, currentIndex),
      );
    } else {
      return MaterialCompactScaffold(
        appBar: material.AppBar(
          title: title,
        ),
        currentIndex: currentIndex,
        onSelected: onSelected,
        destinations: navigationItems
            .map<material.NavigationDestination>((e) => e.materialItem())
            .toList(),
        body: childBuilder(context, currentIndex),
      );
    }
  }

  @override
  Widget yaruWidgetBuilder(BuildContext context) {
    // Return based on compactMode
    // Normal uses YaruMasterDetailPage: https://github.com/ubuntu/yaru_widgets.dart/blob/8016dcaa82bc99654c49e868c8a149e94be9cab4/example/lib/example.dart#L56
    // Comapct uses material Scaffold: https://github.com/ubuntu/yaru_widgets.dart/blob/8016dcaa82bc99654c49e868c8a149e94be9cab4/example/lib/example.dart#L124
    // Source: https://github.com/ubuntu/yaru_widgets.dart/blob/8016dcaa82bc99654c49e868c8a149e94be9cab4/example/lib/example.dart#L38
    if (compactMode) {
      return YaruCompactScaffold(
        title: title,
        child: childBuilder,
        currentIndex: currentIndex,
        length: navigationItems.length,
        onSelected: onSelected,
        // Using a builder here as this makes setting [yaru.YaruNavigationRailItem.selected] easier
        navigationRailItemBuilder: (p0, index, selected) {
          AdaptiveNavigationItem item = navigationItems[index];
          return yaru.YaruNavigationRailItem(
            label: Text(item.label ?? ''),
            icon: item.icon,
            style: YaruNavigationRailStyle.labelled,
            selected: currentIndex == index,
          );
        },
      );
    } else {
      return YaruExpandedScaffold(
        title: title,
        child: childBuilder,
        currentIndex: currentIndex,
        length: navigationItems.length,
        onSelected: onSelected,
        // Using a builder here as this makes setting [yaru.YaruMasterTile.selected] easier
        masterTileBuilder: (context, index, selected) {
          AdaptiveNavigationItem item = navigationItems[index];
          return yaru.YaruMasterTile(
            title: Text(item.label ?? ''),
            leading: item.icon,
            selected: currentIndex == index,
          );
        },
      );
    }
  }
}
