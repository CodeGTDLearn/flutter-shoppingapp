import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_indicator.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../custom_grid_item/animated_grid_item.dart';
import '../overview_appbar/badge_cart.dart';
import '../overview_appbar/filter_options.dart';
import 'icustom_scaffold.dart';

class StaggeredScaffold implements ICustomScaffold {
  Widget customScaffold(_drawer, _controller, _appbar) {
    _controller.applyPopupFilter(FilterOptions.All);
    _appbar.cart = Get.find<BadgeCart>();

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: _appbar,
        drawer: _drawer,
        body: Obx(() => _controller.gridItemsObs.value.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomIndicator.message(message: NO_PROD, fontSize: 20)
              ])))
            : AnimationLimiter(
                child: GridView.count(
                    crossAxisCount: 2,
                    children:
                        List.generate(_controller.gridItemsObs.value.length, (index) {
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
                                      )))));
                    })))));
  }
}