import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class UiUtils {
  double usefulHeight(BuildContext context, AppBar appBar) {
    return MediaQuery.of(context).size.height -
        (screenBotton(context) + screenTop(context) + appBar.preferredSize.height);
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
}