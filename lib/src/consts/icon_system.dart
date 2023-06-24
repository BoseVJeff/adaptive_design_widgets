import 'package:adaptive_design_widgets/adaptive_design_widgets.dart';
import 'package:flutter/widgets.dart';

enum IconSystem {
  /// Mostly Material 2, intended as fallback for when Material Symbols are unavailable
  materialIcons,
  // Mostly Material 3
  /// Uses `material_symbols_icons` as stop-gap untill official support
  // TODO: Use after material symbol packages are implemented
  materialSymbols,
  cupertinoIcons,
  // From fluent_ui
  fluentIcons,
  // From fluentui_system_icons
  msFluentIcons,
  macosIcons,
  yaruIcons,
  fontAwesomeIcons,
  defaultIcons;

  /* static IconSystem get platform {
    String os = Platform.operatingSystem;
    switch (os) {
      case 'fuchsia':
      case 'android':
        return IconSystem.materialIcons;
      case 'ios':
        return IconSystem.cupertinoIcons;
      case 'windows':
        return IconSystem.fluentIcons;
      case 'macos':
        return IconSystem.macosIcons;
      case 'linux':
        return IconSystem.yaruIcons;
      default:
        return IconSystem.materialIcons;
    }
  } */

  /// Get the [IconSystem] corresponding to the given [DesignSystem].
  ///
  /// Setting `preferSystemIcons` to `true` returns the official-ish icon set instead of using the set provided alongside the rest of the widgets.
  /// Currently, this only has an effect on Windows ([IconSystem.msFluentIcons] vs [IconSystem.fluentIcons]).
  /// [DesignSystem.yaru] always returns the official set regardless of this value.
  factory IconSystem.defaultIconSystem(
    DesignSystem designSystem, {
    /// Set this parameter to `true` to return the icon set endorsed by the platform maker instead of using the icons bundled with the rest of the packages.
    preferSystemIcons = false,
  }) {
    switch (designSystem) {
      case DesignSystem.material:
      // TODO: Remove this fallthrough once Material Symbols are available
      // case DesignSystem.material2:
      //   return IconSystem.materialIcons;
      case DesignSystem.cupertino:
        return IconSystem.cupertinoIcons;
      case DesignSystem.fluent:
        return (preferSystemIcons)
            ? IconSystem.msFluentIcons
            : IconSystem.fluentIcons;
      case DesignSystem.macos:
        return IconSystem.macosIcons;
      case DesignSystem.yaru:
        return IconSystem.yaruIcons;
      case DesignSystem.platform:
        return IconSystem.defaultIconSystem(
          DesignSystem.platformDesignSystem(),
          preferSystemIcons: preferSystemIcons,
        );
    }
  }

  static IconSystem of(BuildContext context) =>
      DesignAncestor.iconSystemOf(context);
}
