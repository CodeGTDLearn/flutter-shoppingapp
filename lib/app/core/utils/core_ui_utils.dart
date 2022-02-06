import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CoreUiUtils {
  double usefulHeight(BuildContext context, double superiorBar) {
    return MediaQuery.of(context).size.height -
        (screenBotton(context) + screenTop(context) + superiorBar);
  }

  double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double usefulWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenBotton(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  double screenTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  Size sizeNoContext() {
    return WidgetsBinding.instance!.window.physicalSize;
  }

  double widthNoContext() {
    return sizeNoContext().width;
  }

  double heightNoContext() {
    return sizeNoContext().height;
  }
}