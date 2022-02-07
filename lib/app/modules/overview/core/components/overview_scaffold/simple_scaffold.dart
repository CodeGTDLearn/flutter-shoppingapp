import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../../core/components/badge/core_badge_cart.dart';
import '../../../../../core/components/core_adaptive_indicator.dart';
import '../../../../../core/texts/core_messages.dart';
import '../../overview_keys.dart';
import '../custom_grid_item/animated_grid_item.dart';
import '../overview_appbar/filter_options_enum.dart';
import 'ioverview_scaffold.dart';

class SimpleScaffold implements IOverviewScaffold {
  final _messages = Get.find<CoreMessages>();
  final _keys = Get.find<OverviewKeys>();

  Widget overviewScaffold(
    _drawer,
    _controller,
    _sliverAppbar,
  ) {
    _controller.applyPopupFilter(FilterOptionsEnum.All);
    _sliverAppbar.cart = Get.find<CoreBadgeCart>();

    return Scaffold(
        key: _keys.k_ov_scfld_glob_key(),
        drawer: _drawer,
        body: Obx(() => _controller.gridItemsObs.value.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CoreAdaptiveIndicator.message(message: _messages.no_products_yet, fontSize: 20)
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