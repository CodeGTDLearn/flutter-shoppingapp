import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../keys/global_widgets_keys.dart';


// ignore: avoid_classes_with_only_static_members
class CustomSliverAppBar {
  final _keys = Get.find<GlobalWidgetsKeys>();
  SliverAppBar create(
    String title,
    Function backTapFunction, {
    IconData icon = Icons.arrow_back,
    List<Widget>? actions,
  }) {
    return SliverAppBar(
        floating: true,
        key: Key(_keys.k_sliver_appbar()),
        title: Text(title),
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => backTapFunction.call(),
          child: Icon(icon),
        ),
        actions: actions);
  }
}