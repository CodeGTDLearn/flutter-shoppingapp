import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../core/components/drawer/core_drawer.dart';
import '../controller/overview_controller.dart';
import '../core/components/overview_appbar/overview_sliver_appbar.dart';
import '../core/components/overview_scaffold/ioverview_scaffold.dart';

class OverviewView extends StatelessWidget {
  final _scaffold = Get.find<IOverviewScaffold>();
  final _drawer = Get.find<CoreDrawer>();
  final _controller = Get.find<OverviewController>();
  final _appbar = Get.find<OverviewSliverAppBar>();

  @override
  Widget build(BuildContext context) {
    return _scaffold.overviewScaffold(_drawer, _controller, _appbar);
  }
}