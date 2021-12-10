import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_indicator.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../controller/overview_controller.dart';
import '../custom_grid_item/animated_grid_item.dart';
import '../overview_appbar/filter_options.dart';
import '../overview_appbar/overview_appbar.dart';

class SimpleScaffold extends StatelessWidget {
  final _overviewAppbar = Get.find<OverviewAppBar>();
  final _controller = Get.find<OverviewController>();
  final drawer;

  SimpleScaffold({required this.drawer});

  @override
  Widget build(BuildContext context) {
    _controller.applyPopupFilter(FilterOptions.All);

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: _overviewAppbar,
        drawer: drawer,
        body: Obx(() => _controller.gridItemsObs.value.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomIndicator.message(message: NO_PROD, fontSize: 20)
              ])))
            : GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _controller.gridItemsObs.value.length,
                itemBuilder: (_, index) => AnimatedGridItem(
                      _controller.gridItemsObs.value.elementAt(index),
                      index.toString(),
                    ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10))));
  }
}