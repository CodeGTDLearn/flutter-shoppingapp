import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/appbarr.dart';
import '../../../core/components/drawwer.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewView extends StatelessWidget {
  final EnumFilter enumFilter = EnumFilter.All;

  OverviewView({enumFilter});

  Widget build(BuildContext context) {
    return Scaffold(
      key: K_OV_SCFLD_GLOB_KEY,
      appBar: AppBarr(enumFilter: enumFilter),
      drawer: Get.find<Drawwer>(),
      body: OverviewGrid(enumFilter, Get.find<OverviewController>()),
    );
  }
}
