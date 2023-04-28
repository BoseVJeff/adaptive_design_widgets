import 'package:adaptive_design_widgets/design_systems.dart';
import 'package:flutter/foundation.dart';

class DesignSystemProvider extends ChangeNotifier {
  DesignSystem designSystem = DesignSystem.material;

  IconSystem iconSystem = IconSystem.material;

  void setDesignSystem(DesignSystem newDesignSystem) {
    designSystem = newDesignSystem;
    notifyListeners();
  }
}
