import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_indicator.dart';
import '../../../../core/keys/modules/overview_keys.dart';
import '../../../../core/texts/messages.dart';
import '../custom_grid_item/animated_grid_item.dart';
import '../overview_appbar/filter_options.dart';
import 'icustom_scaffold.dart';

class StaggeredScaffold implements ICustomScaffold {
  final _messages = Get.find<Messages>();
  Widget customScaffold(_drawer, _controller, _sliverAppbar) {
    _controller.applyPopupFilter(FilterOptions.All);

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        drawer: _drawer,
        body: Obx(() => _controller.gridItemsObs.value.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomIndicator.message(message: _messages.no_products_yet(), fontSize: 20)
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
                                            _controller.gridItemsObs.value
                                                .elementAt(index),
                                            index.toString(),
                                          )))));
                        }))),
              ])));
  }
}