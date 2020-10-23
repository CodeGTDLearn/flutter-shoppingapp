import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/overview_controller.dart';
import 'filter_favorite_enum.dart';
import 'overview_grid_item.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final EnumFilter filter;
  final OverviewController overviewController;

  OverviewGrid(this.filter, this.overviewController);

  @override
  Widget build(BuildContext context) {

    overviewController.getProductsByFilter(filter);

    return Obx(
      () => overviewController.filteredProductsObs.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: overviewController.filteredProductsObs.length,
              itemBuilder: (ctx, item) =>
                  OverviewGridItem(overviewController.filteredProductsObs[item]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            ),
    );
  }
}
