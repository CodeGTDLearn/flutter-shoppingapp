import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../modules/overview/components/overview_grid_item.dart';
import '../../../modules/overview/controller/overview_controller.dart';
import 'icustom_gridview.dart';

class OverviewSimpleGridview implements ICustomGridview {
  final _controller = Get.find<OverviewController>();
  final columnCount;

  OverviewSimpleGridview({this.columnCount = 1});

  @override
  Widget create() {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _controller.overviewViewGridViewItemsObs.length,
        itemBuilder: (_, index) => OverviewGridItem(
            _controller.overviewViewGridViewItemsObs[index], index.toString()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10));
  }
}