import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
// import 'package:yaru/yaru.dart' as yaru;
// import 'package:yaru_widgets/yaru_widgets.dart' as yaru;

class AdaptiveNavigationItem {
  AdaptiveNavigationItem({
    required this.icon,
    required this.label,
  });

  final Widget icon;

  final String? label;

  cupertino.BottomNavigationBarItem cupertinoItem() {
    return cupertino.BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }

  fluent.PaneItem fluentItem() {
    return fluent.PaneItem(
      icon: icon,
      title: Text(label ?? ''),
      // Using this as it will be overridden
      body: const SizedBox.shrink(),
    );
  }

  macos.SidebarItem macosItem() {
    return macos.SidebarItem(
      label: Text(label ?? ''),
      leading: icon,
    );
  }

  material.NavigationDestination materialItem() {
    return material.NavigationDestination(
      icon: icon,
      label: label ?? '',
    );
  }

  material.NavigationDrawerDestination materialDrawerItem() {
    return material.NavigationDrawerDestination(
      icon: icon,
      label: Text(label ?? ''),
    );
  }

  // Implemented inline
  /* yaru.YaruMasterTile yaruMasterTile() {
    return yaru.YaruMasterTile(
      title: Text(label ?? ''),
      leading: icon,
    );
  }

  yaru.YaruNavigationRailItem yaruNavigationRailItem() {
    return yaru.YaruNavigationRailItem(
      label: Text(label ?? ''),
      icon: icon,
      
      style: yaru.YaruNavigationRailStyle.labelled,
    );
  } */
}
