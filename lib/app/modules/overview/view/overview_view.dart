import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../core/global_widgets/custom_drawer.dart';
import '../components/overview_appbar/overview_sliver_appbar.dart';
import '../components/overview_scaffold/ioverview_scaffold.dart';
import '../controller/overview_controller.dart';

class OverviewView extends StatelessWidget {
  final _drawer = Get.find<CustomDrawer>();
  final _controller = Get.find<OverviewController>();
  final _appbar = Get.find<OverviewSliverAppBar>();
  final _scaffold = Get.find<IOverviewScaffold>();

  @override
  Widget build(BuildContext context) {
    return _scaffold.overviewScaffold(_drawer, _controller, _appbar);
  }
}