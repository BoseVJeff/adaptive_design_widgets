import 'package:adaptive_design_widgets/src/consts/design_system.dart';
import 'package:flutter/widgets.dart';

/// Applies a paticular [DesignSystem] to its descendent widgets.
///
/// All adaptive widgets listen to the [DesignSystem] set here to decide which widget they should display.
class DesignAncestor extends StatefulWidget {
  const DesignAncestor({
    super.key,
    this.designSystem = DesignSystem.material,
    required this.child,
  });

  /// The [DesignSystem] used by descendent widgets
  ///
  /// If not specified, the default value is [DesignSystem.material].
  final DesignSystem designSystem;

  final Widget child;

  /// Set the [DesignSystem] for the nearest [DesignAncestor] if it exists. Does noting otherwise.
  ///
  /// This method should be used mainly for tests and other smaller demo purposes. This is beacuse it uses the inefficent [BuildContext.findAncestorStateOfType] to trigger a [State.setState] in the corresponding state class.
  /// For proper use, consider supplying the [DesignSystem] from a parent [StatefulWidget] or using another state management system.
  static void setDesignSystem(
    BuildContext context,
    DesignSystem designSystem,
  ) {
    State<DesignAncestor>? ancestor =
        context.findAncestorStateOfType<State<DesignAncestor>>();
    if (ancestor != null) {
      (ancestor as _DesignAncestorState).setDesignSystem(designSystem);
      return;
    } else {
      return;
    }
  }

  @override
  State<DesignAncestor> createState() => _DesignAncestorState();
}

class _DesignAncestorState extends State<DesignAncestor> {
  late DesignSystem system;

  @override
  void initState() {
    super.initState();

    // Set initial state to the one defined by user
    system = widget.designSystem;
  }

  void setDesignSystem(DesignSystem newDesignSystem) {
    setState(() {
      system = newDesignSystem;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return DesignAncestorData(
      // Setting the key here to ensure that this widget is not unnecessarily rebuilt when the parent widget changes.
      key: ValueKey<DesignSystem>(system),
      designSystem: system,
      child: widget.child,
    );
  }
}

/// Meant for internal use only. Use [DesignAncestor] instead to provide a [DesignSystem] to children.
///
/// This class is public in order to make it possible for [DesignSystem.of] to exist. If this were not the case, then [DesignAncestorData.of] would need to be necessarily used, which is a less intuitive name.
///
/// Implementations of the [DesignAncestorData.of] and [DesignAncestorData.maybeOf] are taken verbatim from the official Flutter docs on [InheritedWidget].
class DesignAncestorData extends InheritedWidget {
  const DesignAncestorData({
    super.key,
    required this.designSystem,
    required super.child,
  });

  /// A [DesignSystem] that is provided to descendent widgets
  final DesignSystem designSystem;

  static DesignAncestorData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DesignAncestorData>();

  static DesignAncestorData of(BuildContext context) {
    final DesignAncestorData? ancestor = maybeOf(context);
    assert(
      ancestor != null,
      'No `DesignAncestor` or `DesignAncestorData` found in context.',
    );
    return ancestor!;
  }

  @override
  bool updateShouldNotify(DesignAncestorData oldWidget) {
    // Only update if the design system has changed
    return oldWidget.designSystem != designSystem;
  }
}
