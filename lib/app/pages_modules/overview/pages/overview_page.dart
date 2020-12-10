import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file:///C:/Users/SERVIDOR/Projects/flutter-shoppingapp/lib/app/pages_modules/pages_generic_components/custom_app_bar.dart';

import '../../pages_generic_components/custom_drawer.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';

class OverviewPage extends StatelessWidget  {
  final EnumFilter _enumFilter;

  OverviewPage(this._enumFilter);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(enumFilter: _enumFilter),
        drawer: CustomDrawer(),
        body: OverviewGrid(_enumFilter, Get.find<OverviewController>()));
  }
}
