import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// ignore: avoid_classes_with_only_static_members
class AdaptiveWidgetUtils {
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

  PlatformElevatedButton button({
    required Function onPressed,
    required text,
    required textStyle,
  }) {
    return PlatformElevatedButton(
      onPressed: () => onPressed.call(),
      child: PlatformText(text, style: textStyle),
    );
  }
}