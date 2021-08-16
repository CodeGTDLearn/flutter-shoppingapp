import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/drawwer.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewView extends StatelessWidget {
  final EnumFilter filter = EnumFilter.All;

  OverviewView({enumFilter});

  Widget build(BuildContext context) {
    return Scaffold(
      key: K_OV_SCFLD_GLOB_KEY,
      appBar: CustomAppBar(enumFilter: filter),
      drawer: Get.find<Drawwer>(),
      body: OverviewGrid(filter, Get.find<OverviewController>()),
    );
  }
}
