import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/modules/overview/core/overview_scaffold/addcart_scaffold.dart';

import '../../../core/custom_widgets/custom_drawer.dart';

class OverviewView extends StatefulWidget {
  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  final _drawer = Get.find<CustomDrawer>();

  @override
  Widget build(BuildContext context) {
    return AddCartScaffold(drawer: _drawer);
    // return SimpleScaffold(drawer: _drawer);
    // return StaggeredScaffold(drawer: _drawer);
  }
}