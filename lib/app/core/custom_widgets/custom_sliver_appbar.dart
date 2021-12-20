import 'package:flutter/material.dart';

import '../keys/overview_keys.dart';

// ignore: avoid_classes_with_only_static_members
class CustomSliverAppBar {
  SliverAppBar create(
    String title,
    Function backTapFunction, {
    IconData icon = Icons.arrow_back,
    List<Widget>? actions,
  }) {
    return SliverAppBar(
        floating: true,
        key: Key(K_DRW_APPBAR_BTN),
        title: Text(title),
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => backTapFunction.call(),
          child: Icon(icon),
        ),
        actions: actions);
  }
}