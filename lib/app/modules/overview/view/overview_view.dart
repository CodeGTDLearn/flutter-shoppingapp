import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_drawer.dart';
import '../../../core/keys/overview_keys.dart';
import '../core/overview_scaffold/overview_simple_scaffold.dart';

class OverviewView extends StatefulWidget {
  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  final _drawer = Get.find<CustomDrawer>();

  @override
  Widget build(BuildContext context) {
    return OverviewSimpleScaffold(
      drawer: _drawer,
      scaffoldKey: K_OV_SCFLD_GLOB_KEY,
    );
  }
}