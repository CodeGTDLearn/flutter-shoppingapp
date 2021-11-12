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

    var _columnCount = 1;
    var _gridLenght = 1;

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: CustomAppBar(filter: EnumFilter.All),
        drawer: Get.find<CustomDrawer>(),
        body: Obx(
          () => _controller.overviewViewGridViewItemsObs.isEmpty
              ? _overviewNoProductsInDb_info_singleChildScrollView()
              : AnimationLimiter(
                  child: GridView.count(
                  crossAxisCount: _columnCount,
                  children: List.generate(_gridLenght, (index) {
                    return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: _columnCount,
                        child: ScaleAnimation(
                          duration: Duration(milliseconds: 1000),
                          child: FadeInAnimation(
                              // child: _overviewGridItems_gridView(_controller),
                              child: OverviewGridItem(
                                  _controller.overviewViewGridViewItemsObs[index],
                                  index.toString())),
                        ));
                  }),
                )),
        ));
  }

  GridView _overviewGridItems_gridView(OverviewController controller) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: controller.overviewViewGridViewItemsObs.length,
        itemBuilder: (_, item) => OverviewGridItem(
            controller.overviewViewGridViewItemsObs[item], item.toString()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10));
  }

  SingleChildScrollView _overviewNoProductsInDb_info_singleChildScrollView() {
    return SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomIndicator.message(message: NO_PROD, fontSize: 20)])));
  }
}