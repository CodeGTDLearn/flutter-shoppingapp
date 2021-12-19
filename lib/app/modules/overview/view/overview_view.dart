import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_drawer.dart';
import '../controller/overview_controller.dart';
import '../core/overview_appbar/overview_sliver_appbar.dart';
import '../core/overview_scaffold/icustom_scaffold.dart';

class OverviewView extends StatelessWidget {
  final _drawer = Get.find<CustomDrawer>();
  final _controller = Get.find<OverviewController>();
  final _appbar = Get.find<OverviewSliverAppBar>();
  final _scaffold = Get.find<ICustomScaffold>();

  @override
  Widget build(BuildContext context) {
    return _scaffold.customScaffold(_drawer, _controller, _appbar);
  }
}