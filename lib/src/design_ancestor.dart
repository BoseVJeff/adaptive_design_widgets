import 'package:adaptive_design_widgets/src/consts/design_system.dart';
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
    required DesignSystem? intitialDesignSystem,
    required super.child,
  }) {
    if (intitialDesignSystem != null) {
      _designSystemNotifier.value = intitialDesignSystem;
    }
  }

  final ValueNotifier<DesignSystem> _designSystemNotifier =
      ValueNotifier(DesignSystem.platform);

  @override
  bool updateShouldNotify(_DesignData oldWidget) {
    // Only update if the design system has changed
    return oldWidget._designSystemNotifier.value != _designSystemNotifier.value;
    // return true;
  }
}

/// Applies a [DesignSystem] to descendent widgets.
///
/// To update the [DesignSystem], use the [DesignAncestor.setDesignSystemOf] method.
///
/// To build a widget that updates in response to changes in [DesignSystem], use a [ValueListenableBuilder], using [DesignAncestor.valueNotifierOf] as the [ValueNotifier].
/// NOTE: If you do not care about having the value be automatically updated, either because it is handled elsewhere or because it is not needed, use [DesignSystem.of] instead.
interface class DesignAncestor extends StatelessWidget {
  const DesignAncestor({
    super.key,
    this.initialDesignSystem,
    required this.child,
  });

  final DesignSystem? initialDesignSystem;
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
      debugPrint('Setting design system to $newDesignSystem');
      inheritedWidgetOfExactType._designSystemNotifier.value = newDesignSystem;
    }
    return;
  }

  static DesignSystem of(BuildContext context) {
    var inheritedWidgetOfExactType =
        context.dependOnInheritedWidgetOfExactType<_DesignData>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a D2 ancestor higher in the widget tree',
    );
    return inheritedWidgetOfExactType!._designSystemNotifier.value;
  }

  static ValueNotifier<DesignSystem> valueNotifierOf(BuildContext context) {
    var inheritedWidgetOfExactType =
        context.dependOnInheritedWidgetOfExactType<_DesignData>();
    assert(
      inheritedWidgetOfExactType != null,
      'No DesignAncestor found in context. Consider supplying a D2 ancestor higher in the widget tree',
    );
    return inheritedWidgetOfExactType!._designSystemNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return _DesignData(
      // In case a user decides to update the design system by mantaining state above this widget, this key ensures that the behaviour remains predictable and the widgets are correctly updated.
      key: ValueKey(initialDesignSystem),
      intitialDesignSystem: initialDesignSystem,
      child: child,
    );
  }
}
