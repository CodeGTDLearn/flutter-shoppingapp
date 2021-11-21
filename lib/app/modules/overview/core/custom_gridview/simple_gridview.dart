import 'package:flutter/material.dart';

import '../griditem.dart';
import 'icustom_gridview.dart';

class SimpleGridview implements ICustomGridview {
  final columnCount;
  final gridItems;

  SimpleGridview({
    this.columnCount = 1,
    this.gridItems,
  });

  @override
  Widget create() {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: gridItems.length,
        itemBuilder: (_, index) => GridItem(
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