import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../components_keys.dart';

// ignore: avoid_classes_with_only_static_members
class CustomAppBar {
  final _keys = Get.find<ComponentsKeys>();

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