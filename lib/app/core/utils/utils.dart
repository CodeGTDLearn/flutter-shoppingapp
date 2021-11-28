import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static double usefulHeight(BuildContext context, AppBar appBar) {
    return MediaQuery.of(context).size.height -
        (screenBotton(context) + screenTop(context) + appBar.preferredSize.height);
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double usefulWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenBotton(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double screenTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}