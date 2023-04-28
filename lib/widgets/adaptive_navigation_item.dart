import 'package:adaptive_design_widgets/adaptive_widget_interface.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:go_router/go_router.dart' as go_router;

class AdaptiveNavigationItem {
  const AdaptiveNavigationItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  /// The icon used for the item
  final Widget icon;

  /// The text used for the item
  /// Is a String as that is required in the Cupertino stuff
  final String label;

  /// The callback that is called when this item is tapped/clicked
  final VoidCallback? onTap;

  factory AdaptiveNavigationItem.fromGoRoute(go_router.GoRoute route) {
    final String lastPathSegment =
        Uri.tryParse(route.path)?.pathSegments.last ?? '';
    final Widget icon = (lastPathSegment.isNotEmpty)
        ? Text(lastPathSegment.characters.first)
        : const Text('Home');
    return AdaptiveNavigationItem(
      // icon: Text(lastPathSegment.characters.first),
      icon: icon,
      label: lastPathSegment,
    );
  }
}
