import 'package:flutter/material.dart';

import '../../../inventory/entity/product.dart';
import '../custom_grid_item/animated_grid_item.dart';
import 'icustom_gridview.dart';

class SimpleGridview implements ICustomGridview {
  final columnCount;
  final gridItems;

  SimpleGridview({
    this.columnCount = 1,
    this.gridItems,
  });

  @override
  Widget create(int columnCount, List<Product> gridItems, [int delayMilliseconds = 500]) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: gridItems.length,
        itemBuilder: (_, index) =>
            AnimatedGridItem(gridItems.elementAt(index), index.toString()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10));
  }
}