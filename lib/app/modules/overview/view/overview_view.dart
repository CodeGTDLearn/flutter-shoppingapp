import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_drawer.dart';
import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/keys/overview_keys.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../controller/overview_controller.dart';
import '../core/custom_gridview/staggered_gridview.dart';
import '../core/overview_appbar/filter_options.dart';
import '../core/overview_appbar/overview_appbar.dart';

class OverviewView extends StatelessWidget {
  final _appbar = Get.find<OverviewAppBar>();
  final _drawer = Get.find<CustomDrawer>();
  final _controller = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    _controller.applyPopupFilter(FilterOptions.All);

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: _appbar,
        drawer: _drawer,
        body: Obx(
          () => _controller.overviewViewGridViewItemsObs.isEmpty
              ? _overviewGrid_noProductsInDb()
              : StaggeredGridview(
                  columnCount: 2,
                  gridItems: _controller.overviewViewGridViewItemsObs,
                ).create(),
        ));
  }

  SingleChildScrollView _overviewGrid_noProductsInDb() {
    return SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomIndicator.message(message: NO_PROD, fontSize: 20)])));
  }
}