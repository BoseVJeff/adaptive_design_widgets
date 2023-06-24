import 'package:adaptive_design_widgets/src/consts/design_system.dart';
import 'package:adaptive_design_widgets/src/consts/icon_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material
    show Theme; // Only for doc comments

/// Internal Implementation.
///
/// Done in this manner as this reflects the structure used in [material.Theme].
///
/// Uses a [ValueNotifier] as this allows for better DX by explicitly forcing a [ValueListenableBuilder]. Verbosity can be avoided by using an interface that implements it for all classes that need it.
interface class _DesignData extends InheritedWidget {
  _DesignData({
    super.key,
    DesignSystem? intitialDesignSystem,
    required super.child,
  }) {
    if (intitialDesignSystem != null) {
      _designSystemNotifier.value = intitialDesignSystem;
    }
  }

  /// The notifier that stores the current [DesignSystem] of the widgets.
  final ValueNotifier<DesignSystem> _designSystemNotifier =
      ValueNotifier(DesignSystem.platform);

  @override
  bool updateShouldNotify(_DesignData oldWidget) {
    // Only update if the [ValueNotifier] has changed.
    return oldWidget._designSystemNotifier != _designSystemNotifier;
  }
}

interface class _IconDesign extends InheritedWidget {
  _IconDesign({
    super.key,
    IconSystem? intialIconSystem,
    required super.child,
  }) {
    if (intialIconSystem != null) {
      _iconSystemNotifier.value = intialIconSystem;
    }
  }

  final ValueNotifier<IconSystem> _iconSystemNotifier =
      ValueNotifier(IconSystem.defaultIcons);

  @override
  bool updateShouldNotify(_IconDesign oldWidget) {
    // Only update if the icon system has changed
    return oldWidget._iconSystemNotifier != _iconSystemNotifier;
  }
}

/// Applies a [DesignSystem] to descendent widgets.
///
/// To update the [DesignSystem], use the [DesignAncestor.setDesignSystemOf] method.
///
/// To build a widget that updates in response to changes in [DesignSystem], use a [ValueListenableBuilder], using [DesignAncestor.designSystemNotifierOf] as the [ValueNotifier].
/// To build a widget that updates in response to changes in [IconSystem], use a [ValueListenableBuilder], using [DesignAncestor.iconsSystemNotifierOf] as the [ValueNotifier].
/// NOTE: If you do not care about having the value be automatically updated, either because it is handled elsewhere or because it is not needed, use [DesignSystem.of] instead.
interface class DesignAncestor extends StatelessWidget {
  const DesignAncestor({
    super.key,
    this.initialDesignSystem,
    this.intialIconSystem,
    required this.child,
  });

  final DesignSystem? initialDesignSystem;
  final IconSystem? intialIconSystem;
  final Widget child;

  static void setDesignSystemOf(
    BuildContext context,
    DesignSystem newDesignSystem,
  ) {
    final _DesignData? inheritedWidgetOfExactType =
        context.getInheritedWidgetOfExactType<_DesignData>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a D2 ancestor higher in the widget tree',
    );
    if (inheritedWidgetOfExactType != null) {
      // debugPrint('Setting design system to $newDesignSystem');
      inheritedWidgetOfExactType._designSystemNotifier.value = newDesignSystem;
    }
    return;
  }

  static void setIconSystemOf(
    BuildContext context,
    IconSystem newIconSystem,
  ) {
    final _IconDesign? inheritedWidgetOfExactType =
        context.getInheritedWidgetOfExactType<_IconDesign>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a D2 ancestor higher in the widget tree',
    );
    if (inheritedWidgetOfExactType != null) {
      // debugPrint('Setting design system to $newIconSystem');
      inheritedWidgetOfExactType._iconSystemNotifier.value = newIconSystem;
    }
    return;
  }

  static DesignSystem designSystemOf(BuildContext context) {
    var inheritedWidgetOfExactType =
        context.dependOnInheritedWidgetOfExactType<_DesignData>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a D2 ancestor higher in the widget tree',
    );
    return inheritedWidgetOfExactType!._designSystemNotifier.value;
  }

  static IconSystem iconSystemOf(BuildContext context) {
    var inheritedWidgetOfExactType =
        context.dependOnInheritedWidgetOfExactType<_IconDesign>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a D2 ancestor higher in the widget tree',
    );
    return inheritedWidgetOfExactType!._iconSystemNotifier.value;
  }

  static ValueNotifier<DesignSystem> designSystemNotifierOf(
    BuildContext context,
  ) {
    _DesignData? inheritedWidgetOfExactType =
        context.dependOnInheritedWidgetOfExactType<_DesignData>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a DesignAncestor higher in the widget tree',
    );
    return inheritedWidgetOfExactType!._designSystemNotifier;
  }

  static ValueNotifier<IconSystem> iconsSystemNotifierOf(
    BuildContext context,
  ) {
    _IconDesign? inheritedWidgetOfExactType =
        context.dependOnInheritedWidgetOfExactType<_IconDesign>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a DesignAncestor higher in the widget tree',
    );
    return inheritedWidgetOfExactType!._iconSystemNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return _DesignData(
      // In case a user decides to update the design system by mantaining state above this widget, this key ensures that the behaviour remains predictable and the widgets are correctly updated.
      key: ValueKey<DesignSystem?>(initialDesignSystem),
      intitialDesignSystem: initialDesignSystem,
      child: _IconDesign(
        key: ValueKey<IconSystem?>(intialIconSystem),
        intialIconSystem: intialIconSystem,
        child: child,
      ),
    );
  }
}
