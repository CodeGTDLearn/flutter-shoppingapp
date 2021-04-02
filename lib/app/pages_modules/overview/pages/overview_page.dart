import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../components/filter_favorite_enum.dart';
import '../components/overview_grid.dart';
import '../controller/overview_controller.dart';
import '../core/overview_widget_keys.dart';

class OverviewPage extends StatelessWidget {
  final EnumFilter enumFilter;

  OverviewPage({this.enumFilter});

  Widget build(BuildContext context) {
    return Scaffold(
      key: K_OV_SCFLD_GLOB_KEY,
      appBar: CustomAppBar(enumFilter: enumFilter),
      drawer: Get.find<CustomDrawer>(),
      body: OverviewGrid(enumFilter, Get.find<OverviewController>()),
    );
  }
}

// class OverviewPage extends StatelessWidget {
//   final EnumFilter enumFilter;
//   final OverviewController controller;
//
//   OverviewPage({this.enumFilter, this.controller});
//
//   Widget build(BuildContext context) {
//
//     controller.getProductsByFilter(enumFilter);
//
//     return Scaffold(
//       key: K_OV_SCFLD_GLOB_KEY,
//
//       // drawer: CustomDrawer(),
//       drawer: Get.find<CustomDrawer>(),
//       appBar: CustomAppBar(enumFilter: enumFilter),
//
//       // body: OverviewGrid(_enumFilter, Get.find<OverviewController>()),
//       body: Obx(
//         () => controller.getFilteredProductsObs().length == 0
//             ? Center(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [CircularProgressIndicator()]))
//             : GridView.builder(
//                 padding: EdgeInsets.all(10),
//                 itemCount: controller.getFilteredProductsObs().length,
//                 itemBuilder: (ctx, index) => OverviewGridItem(
//                     controller.getFilteredProductsObs()[index],
//                     index.toString()),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 3 / 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10)),
//       ),
//     );
//   }
// }
