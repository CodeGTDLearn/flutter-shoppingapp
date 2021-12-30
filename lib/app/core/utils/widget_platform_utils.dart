import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// ignore: avoid_classes_with_only_static_members
class WidgetPlatformUtils {
  PlatformElevatedButton button({required Function onpressed, required child}) {
    return PlatformElevatedButton(
        onPressed: () => onpressed.call(),
        material: (_, __) => MaterialElevatedButtonData(
              child: child,
          style: ButtonStyle(maximumSize: )

            ),
        cupertino: (_, __) => CupertinoElevatedButtonData(
              child: child,
            ));
  }
}