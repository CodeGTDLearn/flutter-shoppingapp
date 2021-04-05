import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewPage extends StatelessWidget {
  final EnumFilter enumFilter;

  OverviewPage({this.enumFilter});

  Widget build(BuildContext context) {
    return Scaffold(
      key: K_OV_SCFLD_GLOB_KEY,
      appBar: CustomAppBar(enumFilter: enumFilter),
      drawer: Get.find<CustomDrawer>(),
      body: OverviewGrid(enumFilter, Get.find<OverviewController>()),
    );
  }
}

