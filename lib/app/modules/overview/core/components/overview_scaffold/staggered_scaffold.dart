import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../../core/components/core_adaptive_indicator.dart';
import '../../../../../core/texts/core_messages.dart';
import '../../overview_keys.dart';
import '../custom_grid_item/animated_grid_item.dart';
import '../overview_appbar/filter_options_enum.dart';
import 'ioverview_scaffold.dart';

class StaggeredScaffold implements IOverviewScaffold {
  final _messages = Get.find<CoreMessages>();
  final _keys = Get.find<OverviewKeys>();

  Widget overviewScaffold(_drawer, _controller, _sliverAppbar) {
    _controller.applyPopupFilter(FilterOptionsEnum.All);

    return Scaffold(
        key: _keys.k_ov_scfld_glob_key(),
        drawer: _drawer,
        body: Obx(() => _controller.gridItemsObs.value.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CoreAdaptiveIndicator.message(message: _messages.no_products_yet, fontSize: 20)
              ])))
            : CustomScrollView(slivers: [
                _sliverAppbar,
                AnimationLimiter(
                    child: SliverGrid.count(
                        crossAxisCount: 2,
                        children: List.generate(_controller.gridItemsObs.length, (index) {
                          return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 2,
                              child: ScaleAnimation(
                                  duration: Duration(milliseconds: 500),
                                  child: FadeInAnimation(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedGridItem(
                                      _controller.gridItemsObs.value.elementAt(index),
                                      index.toString(),
                                    ),
                                  ))));
                        }))),
              ])));
  }
}