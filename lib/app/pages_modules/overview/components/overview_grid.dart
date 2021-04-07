import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/overview_controller.dart';
import 'filter_favorite_enum.dart';
import 'overview_grid_item.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final EnumFilter enumFilter;
  final OverviewController controller;

  OverviewGrid(this.enumFilter, this.controller);

  @override
  Widget build(BuildContext context) {
    controller.getProductsByFilter(enumFilter);

    return Obx(() => controller.filteredProductsObs.length == 0
        ? Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()]))
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: controller.filteredProductsObs.length,
            itemBuilder: (ctx, index) => OverviewGridItem(
                  controller.filteredProductsObs[index],
                  index.toString(),
                ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10)));
  }
}
