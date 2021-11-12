import 'package:flutter/material.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';

import 'abstract_custom_gridview.dart';

class SimpleGridview implements AbstractCustomGridview {
  OverviewController controller;
  OverviewGridItem gridItem;

  SimpleGridview(this.controller, this.gridItem);

  Widget gridView() {
    // GridView _overviewGridItems_simpleGridView(OverviewController controller) {
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
    // }
  }
}