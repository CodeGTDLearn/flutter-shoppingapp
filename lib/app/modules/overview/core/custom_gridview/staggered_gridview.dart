import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../gridview_item.dart';
import 'icustom_gridview.dart';

class StaggeredGridview implements ICustomGridview {
  final columnCount;
  final delayMilliseconds;
  final gridItems;

  StaggeredGridview({
    this.columnCount = 1,
    this.delayMilliseconds = 500,
    this.gridItems,
  });

  @override
  Widget create() {
    return AnimationLimiter(
        child: GridView.count(
            crossAxisCount: columnCount,
            children: List.generate(gridItems.length, (index) {
              return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: columnCount,
                  child: ScaleAnimation(
                      duration: Duration(milliseconds: delayMilliseconds),
                      child: FadeInAnimation(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridViewItem(
                                gridItems.elementAt(index),
                                index.toString(),
                              )))));
            })));
  }
}