import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// ignore: avoid_classes_with_only_static_members
class AdaptiveWidgets {
  PlatformIconButton iconButton({
    required Function onPressed,
    double? height,
    required materialIcon,
    required cupertinoIcon,
    required iconColor,
  }) {
    return PlatformIconButton(
      onPressed: () => onPressed.call(),
      materialIcon: Icon(
        materialIcon,
        size: height,
        color: iconColor,
      ),
      cupertinoIcon: Icon(
        cupertinoIcon,
        size: height,
        color: iconColor,
      ),
    );
  }

  Widget elevatedButton({
    required Function onPressed,
    required text,
    required textStyle,
  }) {
    return PlatformElevatedButton(
      onPressed: () => onPressed.call(),
      child: PlatformText(text, style: textStyle),
      material: (_, __) => MaterialElevatedButtonData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(
            left: 6,
            right: 6,
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoElevatedButtonData(
        // minSize: 15,
        padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
      ),
    );
  }
}