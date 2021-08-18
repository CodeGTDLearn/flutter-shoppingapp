import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/app_messages_provided.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/drawwer.dart';
import '../../../core/components/progres_indicator.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid_item.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewView extends StatelessWidget {
  Widget build(BuildContext context) {
    var controller = Get.find<OverviewController>();
    controller.setProductsByFilter(EnumFilter.All);

    return Scaffold(
        key: K_OV_SCFLD_GLOB_KEY,
        appBar: CustomAppBar(enumFilter: EnumFilter.All),
        drawer: Get.find<Drawwer>(),
        body: Obx(() => controller.filteredProductsObs.isEmpty
            ? SingleChildScrollView(
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ProgresIndicator.message(message: NO_PROD, fontSize: 20)
              ])))
            : GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: controller.filteredProductsObs.length,
                itemBuilder: (_, item) => OverviewGridItem(
                    controller.filteredProductsObs[item], item.toString()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10))));
  }
}
