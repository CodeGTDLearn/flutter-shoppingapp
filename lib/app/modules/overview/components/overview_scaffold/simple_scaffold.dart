import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/badge_cart.dart';
import '../../../../core/custom_widgets/custom_indicator.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts/messages.dart';
import '../custom_grid_item/animated_grid_item.dart';
import '../overview_appbar/filter_options.dart';
import 'icustom_scaffold.dart';

class SimpleScaffold implements ICustomScaffold {
  Widget customScaffold(_drawer, _controller, _sliverAppbar,) {
    _controller.applyPopupFilter(FilterOptions.All);
    _sliverAppbar.cart = Get.find<BadgeCart>();

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        drawer: _drawer,
        body: Obx(() => _controller.gridItemsObs.value.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomIndicator.message(message: NO_PROD, fontSize: 20)
              ])))
            : CustomScrollView(
                slivers: [
                  _sliverAppbar,
                  SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      delegate: SliverChildBuilderDelegate(
                        (_, index) => AnimatedGridItem(
                            _controller.gridItemsObs.value.elementAt(index),
                            index.toString()),
                        childCount: _controller.gridItemsObs.length,
                      )),
                ],
              )));
  }
}