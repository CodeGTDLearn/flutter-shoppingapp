import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/components/app_messages_provided.dart';
import '../../../core/components/custom_appbar/custom_appbar.dart';
import '../../../core/components/custom_appbar/filter_favorite_enum.dart';
import '../../../core/components/custom_drawer.dart';
import '../../../core/components/custom_gridview/overview_staggered_gridview.dart';
import '../../../core/components/custom_indicator.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewView extends StatelessWidget {
  Widget build(BuildContext context) {
    var _controller = Get.find<OverviewController>();
    _controller.applyPopupFilter(EnumFilter.All);

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: CustomAppBar(filter: EnumFilter.All),
        drawer: Get.find<CustomDrawer>(),
        body: Obx(
          () => _controller.overviewViewGridViewItemsObs.isEmpty
              ? _overviewGrid_noProductsInDb()
              : OverviewStaggeredGridview(
                  columnCount: 2,
                  gridItems: _controller.overviewViewGridViewItemsObs).create(),
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

// BEFORE STAGGED_GRID_ANIMATION - PACKAGE: flutter_staggered_animations
//
// AnimationLimiter _overviewGrid_staggered(
//     int columnCount, OverviewController controller, int delayMilliseconds) {
//   return AnimationLimiter(
//       child: GridView.count(
//           crossAxisCount: columnCount,
//           children:
//               List.generate(controller.overviewViewGridViewItemsObs.length, (index) {
//             return AnimationConfiguration.staggeredGrid(
//                 position: index,
//                 columnCount: columnCount,
//                 child: ScaleAnimation(
//                   duration: Duration(milliseconds: delayMilliseconds),
//                   child: FadeInAnimation(
//                       child: OverviewGridItem(
//                           controller.overviewViewGridViewItemsObs[index],
//                           index.toString())),
//                 ));
//           })));
// }
// GridView _overviewGrid_simple(OverviewController controller) {
//   return GridView.builder(
//       padding: EdgeInsets.all(10),
//       itemCount: controller.overviewViewGridViewItemsObs.length,
//       itemBuilder: (_, index) => OverviewGridItem(
//           controller.overviewViewGridViewItemsObs[index], index.toString()),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 3 / 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10));
// }