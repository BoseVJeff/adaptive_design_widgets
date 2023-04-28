import 'package:adaptive_design_widgets/adaptive_icon_interface.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fa;
import 'package:yaru_icons/yaru_icons.dart' as yaru;

// Icons included are the ones included in the PlatformAdaptiveIcons class (https://api.flutter.dev/flutter/material/PlatformAdaptiveIcons-class.html)
// Others may be included in the future

// Default icon sizes seem to be 24
class AdaptiveAddIcon extends AdaptiveIconInterface {
  const AdaptiveAddIcon({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = false;

  const AdaptiveAddIcon.filled({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = true;

  final bool _isFilled;

  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget buildCupertinoIcon(BuildContext context) {
    // add_filled or add_solid or equivalent does not exist
    return Icon(
      cupertino.CupertinoIcons.add,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFluentIcon(BuildContext context) {
    // Only use the custom sized icons if size is explicitly mentioned, assume the default 24 set otherwise;
    IconData fluentIconData = fluent.FluentIcons.add_24_regular;

    if (_isFilled) {
      // Use filled variants of icons by default
      fluentIconData = fluent.FluentIcons.add_24_filled;
    }

    if (_isFilled) {
      // Use filled variants of icons
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 14) {
          fluentIconData = fluent.FluentIcons.add_12_filled;
        } else if (size! >= 14 && size! < 18) {
          fluentIconData = fluent.FluentIcons.add_16_filled;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.add_20_filled;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.add_24_filled;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.add_28_filled;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.add_32_filled;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.add_48_filled;
        }
      }
    } else {
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 14) {
          fluentIconData = fluent.FluentIcons.add_12_regular;
        } else if (size! >= 14 && size! < 18) {
          fluentIconData = fluent.FluentIcons.add_16_regular;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.add_20_regular;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.add_24_regular;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.add_28_regular;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.add_32_regular;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.add_48_regular;
        }
      }
    }

    return Icon(
      fluentIconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFontAwesomeIcon(BuildContext context) {
    // No filled variant exists
    return fa.FaIcon(
      fa.FontAwesomeIcons.plus,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMacosIcon(BuildContext context) {
    // No filled variant exists
    return macos.MacosIcon(
      cupertino.CupertinoIcons.add,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMaterialIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        material.Icons.add,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        material.Icons.add_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildYaruIcon(BuildContext context) {
    return Icon(
      yaru.YaruIcons.plus,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

class AdaptiveArrowForwardIcon extends AdaptiveIconInterface {
  const AdaptiveArrowForwardIcon({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = false;

  const AdaptiveArrowForwardIcon.filled({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = true;

  final bool _isFilled;

  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget buildCupertinoIcon(BuildContext context) {
    // add_filled or add_solid or equivalent does not exist
    return Icon(
      cupertino.CupertinoIcons.chevron_forward,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFluentIcon(BuildContext context) {
    // Only use the custom sized icons if size is explicitly mentioned, assume the default 24 set otherwise;
    IconData fluentIconData = fluent.FluentIcons.arrow_right_24_regular;

    if (_isFilled) {
      // Use filled variants of icons by default
      fluentIconData = fluent.FluentIcons.arrow_right_24_filled;
    }

    if (_isFilled) {
      // Use filled variants of icons
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 14) {
          fluentIconData = fluent.FluentIcons.arrow_right_12_filled;
        } else if (size! >= 14 && size! < 18) {
          fluentIconData = fluent.FluentIcons.arrow_right_16_filled;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.arrow_right_20_filled;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.arrow_right_24_filled;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.arrow_right_28_filled;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.arrow_right_32_filled;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.arrow_right_48_filled;
        }
      }
    } else {
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 14) {
          fluentIconData = fluent.FluentIcons.arrow_right_12_regular;
        } else if (size! >= 14 && size! < 18) {
          fluentIconData = fluent.FluentIcons.arrow_right_16_regular;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.arrow_right_20_regular;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.arrow_right_24_regular;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.arrow_right_28_regular;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.arrow_right_32_regular;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.arrow_right_48_regular;
        }
      }
    }

    return Icon(
      fluentIconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFontAwesomeIcon(BuildContext context) {
    // No filled variant exists
    return fa.FaIcon(
      fa.FontAwesomeIcons.arrowRight,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMacosIcon(BuildContext context) {
    // No filled variant exists
    return macos.MacosIcon(
      cupertino.CupertinoIcons.chevron_forward,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMaterialIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        material.Icons.arrow_forward,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        material.Icons.arrow_forward_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildYaruIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        yaru.YaruIcons.arrow_right,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        yaru.YaruIcons.arrow_right_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }
}

class AdaptiveArrowBackIcon extends AdaptiveIconInterface {
  const AdaptiveArrowBackIcon({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = false;

  const AdaptiveArrowBackIcon.filled({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = true;

  final bool _isFilled;

  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget buildCupertinoIcon(BuildContext context) {
    // add_filled or add_solid or equivalent does not exist
    return Icon(
      cupertino.CupertinoIcons.chevron_back,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFluentIcon(BuildContext context) {
    // Only use the custom sized icons if size is explicitly mentioned, assume the default 24 set otherwise;
    IconData fluentIconData = fluent.FluentIcons.arrow_left_24_regular;

    if (_isFilled) {
      // Use filled variants of icons by default
      fluentIconData = fluent.FluentIcons.arrow_left_24_filled;
    }

    if (_isFilled) {
      // Use filled variants of icons
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 14) {
          fluentIconData = fluent.FluentIcons.arrow_left_12_filled;
        } else if (size! >= 14 && size! < 18) {
          fluentIconData = fluent.FluentIcons.arrow_left_16_filled;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.arrow_left_20_filled;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.arrow_left_24_filled;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.arrow_left_28_filled;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.arrow_left_32_filled;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.arrow_left_48_filled;
        }
      }
    } else {
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 14) {
          fluentIconData = fluent.FluentIcons.arrow_left_12_regular;
        } else if (size! >= 14 && size! < 18) {
          fluentIconData = fluent.FluentIcons.arrow_left_16_regular;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.arrow_left_20_regular;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.arrow_left_24_regular;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.arrow_left_28_regular;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.arrow_left_32_regular;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.arrow_left_48_regular;
        }
      }
    }

    return Icon(
      fluentIconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFontAwesomeIcon(BuildContext context) {
    // No filled variant exists
    return fa.FaIcon(
      fa.FontAwesomeIcons.arrowLeft,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMacosIcon(BuildContext context) {
    // No filled variant exists
    return macos.MacosIcon(
      cupertino.CupertinoIcons.chevron_back,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMaterialIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        material.Icons.arrow_back,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        material.Icons.arrow_back_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildYaruIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        yaru.YaruIcons.arrow_left,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        yaru.YaruIcons.arrow_left_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }
}

class AdaptiveFlipCameraIcon extends AdaptiveIconInterface {
  const AdaptiveFlipCameraIcon({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = false;

  const AdaptiveFlipCameraIcon.filled({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = true;

  final bool _isFilled;

  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget buildCupertinoIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        cupertino.CupertinoIcons.camera_rotate_fill,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        cupertino.CupertinoIcons.camera_rotate,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildFluentIcon(BuildContext context) {
    // Only use the custom sized icons if size is explicitly mentioned, assume the default 24 set otherwise;
    IconData fluentIconData = fluent.FluentIcons.camera_switch_24_regular;

    if (_isFilled) {
      // Use filled variants of icons by default
      fluentIconData = fluent.FluentIcons.camera_switch_24_filled;
    }

    if (_isFilled) {
      // Use filled variants of icons
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 22) {
          fluentIconData = fluent.FluentIcons.camera_switch_20_filled;
        } else if (size! >= 22) {
          fluentIconData = fluent.FluentIcons.camera_switch_24_filled;
        }
      }
    } else {
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 22) {
          fluentIconData = fluent.FluentIcons.camera_switch_20_regular;
        } else if (size! >= 22) {
          fluentIconData = fluent.FluentIcons.camera_switch_24_regular;
        }
      }
    }

    return Icon(
      fluentIconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFontAwesomeIcon(BuildContext context) {
    // No filled variant exists
    return fa.FaIcon(
      fa.FontAwesomeIcons.cameraRotate,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMacosIcon(BuildContext context) {
    if (_isFilled) {
      return macos.MacosIcon(
        cupertino.CupertinoIcons.camera_rotate_fill,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return macos.MacosIcon(
        cupertino.CupertinoIcons.camera_rotate,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildMaterialIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        material.Icons.flip_camera_android,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        material.Icons.flip_camera_android_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildYaruIcon(BuildContext context) {
    // HACK: Icon does not exist so using the default camera icon
    if (_isFilled) {
      return Icon(
        yaru.YaruIcons.camera_photo_filed,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        yaru.YaruIcons.camera_photo,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }
}

class AdaptiveMoreIcon extends AdaptiveIconInterface {
  const AdaptiveMoreIcon({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = false;

  const AdaptiveMoreIcon.filled({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = true;

  final bool _isFilled;

  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget buildCupertinoIcon(BuildContext context) {
    // No filled variant available
    return Icon(
      cupertino.CupertinoIcons.ellipsis,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFluentIcon(BuildContext context) {
    // Only use the custom sized icons if size is explicitly mentioned, assume the default 24 set otherwise;
    IconData fluentIconData = fluent.FluentIcons.more_horizontal_24_regular;

    if (_isFilled) {
      // Use filled variants of icons by default
      fluentIconData = fluent.FluentIcons.more_horizontal_24_filled;
    }

    if (_isFilled) {
      // Use filled variants of icons
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 18) {
          fluentIconData = fluent.FluentIcons.more_horizontal_16_filled;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.more_horizontal_20_filled;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.more_horizontal_24_filled;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.more_horizontal_28_filled;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.more_horizontal_32_filled;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.more_horizontal_48_filled;
        }
      }
    } else {
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 18) {
          fluentIconData = fluent.FluentIcons.more_horizontal_16_regular;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.more_horizontal_20_regular;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.more_horizontal_24_regular;
        } else if (size! >= 26 && size! < 30) {
          fluentIconData = fluent.FluentIcons.more_horizontal_28_regular;
        } else if (size! >= 30 && size! < 40) {
          fluentIconData = fluent.FluentIcons.more_horizontal_32_regular;
        } else if (size! >= 40) {
          fluentIconData = fluent.FluentIcons.more_horizontal_48_regular;
        }
      }
    }

    return Icon(
      fluentIconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFontAwesomeIcon(BuildContext context) {
    // No filled variant exists
    return fa.FaIcon(
      fa.FontAwesomeIcons.ellipsis,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMacosIcon(BuildContext context) {
    // No filled variant exists
    return macos.MacosIcon(
      cupertino.CupertinoIcons.ellipsis,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMaterialIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        material.Icons.more_horiz,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        material.Icons.more_horiz_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildYaruIcon(BuildContext context) {
    return Icon(
      yaru.YaruIcons.view_more,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

class AdaptiveShareIcon extends AdaptiveIconInterface {
  const AdaptiveShareIcon({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = false;

  const AdaptiveShareIcon.filled({
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    super.key,
  }) : _isFilled = true;

  final bool _isFilled;

  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget buildCupertinoIcon(BuildContext context) {
    if (!_isFilled) {
      return Icon(
        cupertino.CupertinoIcons.share,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        cupertino.CupertinoIcons.share_solid,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildFluentIcon(BuildContext context) {
    // Only use the custom sized icons if size is explicitly mentioned, assume the default 24 set otherwise;
    IconData fluentIconData = fluent.FluentIcons.share_24_regular;

    if (_isFilled) {
      // Use filled variants of icons by default
      fluentIconData = fluent.FluentIcons.share_24_filled;
    }

    if (_isFilled) {
      // Use filled variants of icons
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 18) {
          fluentIconData = fluent.FluentIcons.share_16_filled;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.share_20_filled;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.share_24_filled;
        } else if (size! >= 26 && size! < 38) {
          fluentIconData = fluent.FluentIcons.share_28_filled;
        } else if (size! >= 38) {
          fluentIconData = fluent.FluentIcons.share_48_filled;
        }
      }
    } else {
      if (size != null) {
        // Icons are selected according to set size
        // Size thresholds are set to be at the midpoint between two available sizes
        // At the exact midpoint, the larger of the two sizes is used to ensure higher quality
        // eg: <14 uses icon_12 while >=14 uses icon_16.

        if (size! < 18) {
          fluentIconData = fluent.FluentIcons.share_16_regular;
        } else if (size! >= 18 && size! < 22) {
          fluentIconData = fluent.FluentIcons.share_20_regular;
        } else if (size! >= 22 && size! < 26) {
          fluentIconData = fluent.FluentIcons.share_24_regular;
        } else if (size! >= 26 && size! < 38) {
          fluentIconData = fluent.FluentIcons.share_28_regular;
        } else if (size! >= 38) {
          fluentIconData = fluent.FluentIcons.share_48_regular;
        }
      }
    }

    return Icon(
      fluentIconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildFontAwesomeIcon(BuildContext context) {
    // No filled variant exists
    return fa.FaIcon(
      fa.FontAwesomeIcons.share,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  @override
  Widget buildMacosIcon(BuildContext context) {
    if (!_isFilled) {
      return macos.MacosIcon(
        cupertino.CupertinoIcons.share,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return macos.MacosIcon(
        cupertino.CupertinoIcons.share_solid,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildMaterialIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        material.Icons.share,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        material.Icons.share_outlined,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }

  @override
  Widget buildYaruIcon(BuildContext context) {
    if (_isFilled) {
      return Icon(
        yaru.YaruIcons.share_filled,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    } else {
      return Icon(
        yaru.YaruIcons.share,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
  }
}
