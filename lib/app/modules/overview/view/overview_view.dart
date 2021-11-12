import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../core/components/app_messages_provided.dart';
import '../../../core/components/custom_appbar/custom_appbar.dart';
import '../../../core/components/custom_appbar/filter_favorite_enum.dart';
import '../../../core/components/custom_drawer.dart';
import '../../../core/components/custom_indicator.dart';
import '../components/overview_grid_item.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewView extends StatelessWidget {
  Widget build(BuildContext context) {
    var _controller = Get.find<OverviewController>();
    _controller.applyPopupFilter(EnumFilter.All);

    var _columnCount = 2;
    var _duration = 500;
    // var _gridLenght = _controller.overviewViewGridViewItemsObs.length;

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: CustomAppBar(filter: EnumFilter.All),
        drawer: Get.find<CustomDrawer>(),
        body: Obx(() => _controller.overviewViewGridViewItemsObs.isEmpty
            ? _overviewNoProductsInDb_infoView()
            : AnimationLimiter(
                child: GridView.count(
                    crossAxisCount: _columnCount,
                    children: List.generate(
                        _controller.overviewViewGridViewItemsObs.length, (index) {
                      return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: _columnCount,
                          child: ScaleAnimation(
                            duration: Duration(milliseconds: _duration),
                            child: FadeInAnimation(
                                child: OverviewGridItem(
                                    _controller.overviewViewGridViewItemsObs[index],
                                    index.toString())),
                          ));
                    })))));
  }

  SingleChildScrollView _overviewNoProductsInDb_infoView() {
    return SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomIndicator.message(message: NO_PROD, fontSize: 20)])));
  }

// GridView _overviewGridItems_simpleGridView(OverviewController controller) {
//   return GridView.builder(
//       padding: EdgeInsets.all(10),
//       itemCount: controller.overviewViewGridViewItemsObs.length,
//       itemBuilder: (_, item) => OverviewGridItem(
//           controller.overviewViewGridViewItemsObs[item], item.toString()),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 3 / 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10));
// }
}

// BEFORE STAGGED_GRID_ANIMATION - PACKAGE: flutter_staggered_animations
//