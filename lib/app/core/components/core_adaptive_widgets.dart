import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// PUB-DEV: https://pub.dev/packages/flutter_platform_widgets
// ignore: avoid_classes_with_only_static_members
class CoreAdaptiveWidgets {
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
    Color? color,
  }) {
    return PlatformElevatedButton(
      onPressed: () => onPressed.call(),
      child: PlatformText(text, style: textStyle,textAlign: TextAlign.center),
      material: (_, __) => MaterialElevatedButtonData(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.only(
            left: 6,
            right: 6,
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoElevatedButtonData(
        color: color,
        padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
      ),
    );
  }
}