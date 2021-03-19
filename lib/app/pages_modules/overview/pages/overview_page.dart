import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewPage extends StatelessWidget {
  final EnumFilter _enumFilter;
  final GlobalKey<ScaffoldState> scaffoldKey;

  OverviewPage(this._enumFilter, [this.scaffoldKey]);

  Widget build(BuildContext context) {
    return Scaffold(
      key: K_SCFLD,
      appBar: CustomAppBar(enumFilter: _enumFilter),
      drawer: CustomDrawer(),
      body: OverviewGrid(_enumFilter, Get.find<OverviewController>()),
    );
  }
}
