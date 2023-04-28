import 'package:adaptive_design_widgets/adaptive_widget_interface.dart';
import 'package:adaptive_design_widgets/widgets/adaptive_navigation_item.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart'
    as material_scaffold;
import 'package:yaru_widgets/widgets.dart';
import 'package:yaru_widgets/yaru_widgets.dart' as yaru;

class AdaptiveScaffold extends AdaptiveWidgetInterface {
  const AdaptiveScaffold({
    required this.navigationItems,
    required this.body,
    required this.title,
    this.currentIndex = 0,
    required this.onSelected,
    super.key,
  });

  /// The list of items to be shown in the sidebar
  final List<AdaptiveNavigationItem> navigationItems;

  /// The widget to be shown in the main body area of the app
  final Widget body;

  /// The index of the item to be shown as selected in the app sidebar
  final int currentIndex;

  /// The title of the page
  final Widget? title;

  /// Callback for when item with index `i` is selected
  final void Function(int?) onSelected;

  // FIXED: Tabbed navigation is broken here
  // This seems to be happening because identical `body` seems to be unsupported
  @override
  material.Widget buildCupertinoWidget(BuildContext context) {
    // Constructing the specific item from the generic item
    final List<cupertino.BottomNavigationBarItem> items = navigationItems
        .map((item) => BottomNavigationBarItem(
              icon: item.icon,
              label: item.label,
            ))
        .toList();

    // Building a custom layout as the standard one seems to break for cases where the body is unchanging, as is the case here
    return Column(
      children: [
        Expanded(
          child: cupertino.CupertinoPageScaffold(
            navigationBar: cupertino.CupertinoNavigationBar(
              middle: title,
            ),
            // Inserting this padding here to avoid body from extending behind navbar
            // Value taken directly from L24 in nav_bar.dart from the flutter source
            // File: flutter\packages\flutter\lib\src\cupertino\nav_bar.dart
            child: Padding(
              padding: const EdgeInsets.only(
                top: cupertino.kMinInteractiveDimensionCupertino,
              ),
              // key: ValueKey<int>(currentIndex),
              child: body,
            ),
          ),
        ),
        cupertino.CupertinoTabBar(
          items: items,
          currentIndex: currentIndex,
          onTap: onSelected,
        ),
      ],
    );
  }

  @override
  material.Widget buildFluentWidget(BuildContext context) {
    // Constructing the specific item from the generic item
    /* final List<fluent.PaneItem> items = navigationItems
        .map<fluent.PaneItem>((item) => fluent.PaneItem(
              icon: item.icon,
              title: Text(item.label),
              body: const SizedBox.shrink(),
            ))
        .toList(); */
    final List<fluent.PaneItem> items = [];

    for (var item in navigationItems) {
      items.add(
        fluent.PaneItem(
          icon: item.icon,
          title: Text(item.label),
          body: const SizedBox.shrink(),
        ),
      );
    }

    return fluent.NavigationView(
      pane: fluent.NavigationPane(
        onChanged: onSelected,
        // Doing it like this as List<NavigationPaneItem> is not a subtype of List<PaneItem>
        // Error: type 'List<NavigationPaneItem>' is not a subtype of type 'List<PaneItem>' of 'other'
        items: [...items],
        // items: items,
        selected: currentIndex,
      ),
      paneBodyBuilder: (_, __) => body,
      appBar: fluent.NavigationAppBar(
        title: title,
      ),
    );
  }

  @override
  material.Widget buildMacosWidget(BuildContext context) {
    // Constructing the specific item from the generic item
    final List<macos.SidebarItem> items = navigationItems
        .map((item) => macos.SidebarItem(
              leading: item.icon,
              label: Text(item.label),
            ))
        .toList();

    return macos.MacosWindow(
      titleBar: macos.TitleBar(
        title: title,
      ),
      sidebar: macos.Sidebar(
        // TODO: Currently follows the value in the docs, look into the proper values
        minWidth: 200,
        builder: (context, scrollController) {
          return macos.SidebarItems(
            items: items,
            currentIndex: currentIndex,
            onChanged: onSelected,
          );
        },
      ),
      // Wrapping in a builder here as reccomended by docs here: https://pub.dev/packages/macos_ui#macoswindow
      child: material.Builder(builder: (context) {
        return macos.MacosScaffold(
          children: [
            macos.ContentArea(
              builder: (_, __) => body,
            ),
          ],
        );
      }),
    );
  }

  @override
  material.Widget buildMaterialWidget(BuildContext context) {
    // Constructing the specific item from the generic item
    final List<material.NavigationDestination> items = navigationItems
        .map((item) => material.NavigationDestination(
              icon: item.icon,
              label: item.label,
            ))
        .toList();

    return material_scaffold.AdaptiveScaffold(
      appBar: material.AppBar(
        title: title,
      ),
      selectedIndex: currentIndex,
      destinations: items,
      onSelectedIndexChange: onSelected,
      body: (_) => body,
    );
  }

  @override
  Widget buildYaruWidget(BuildContext context) {
    return yaru.YaruMasterDetailPage(
      tileBuilder: (context, index, selected) {
        return YaruMasterTile(
          title: Text(navigationItems[index].label),
          leading: navigationItems[index].icon,
        );
      },
      pageBuilder: (context, index) {
        return yaru.YaruDetailPage(
          // TODO: Look into when using YaruWindowTitleBar may be appropriate
          appBar: yaru.YaruTitleBar(
            title: title,
          ),
          body: body,
        );
      },
      onSelected: onSelected,
      initialIndex: currentIndex,
      length: navigationItems.length,
      appBar: yaru.YaruWindowTitleBar(
        title: title,
      ),
    );
  }
}
