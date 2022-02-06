import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../core_components_keys.dart';

// ignore: avoid_classes_with_only_static_members
class CoreAppBar {
  final _keys = Get.find<CoreComponentsKeys>();

  AppBar create(
    String title,
    Function backTapFunction, {
    IconData icon = Icons.arrow_back,
    List<Widget>? actions,
  }) {
    return AppBar(
        key: Key(_keys.k_appbar_drawer()),
        title: Text(title),
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => backTapFunction.call(),
          child: Icon(icon),
        ),
        actions: actions);
  }
}