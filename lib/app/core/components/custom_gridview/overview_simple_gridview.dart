import 'package:flutter/material.dart';

import '../../../modules/overview/components/overview_griditem.dart';
import 'icustom_gridview.dart';

class OverviewSimpleGridview implements ICustomGridview {
  final columnCount;
  final gridItems;

  OverviewSimpleGridview({
    this.columnCount = 1,
    this.gridItems,
  });

  @override
  Widget create() {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: gridItems.length,
        itemBuilder: (_, index) => OverviewGridItem(
              gridItems.elementAt(index),
              index.toString(),
            ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10));
  }
}