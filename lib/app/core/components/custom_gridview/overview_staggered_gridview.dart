import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../modules/overview/components/overview_grid_item.dart';
import 'icustom_gridview.dart';

class OverviewStaggeredGridview implements ICustomGridview {
  final columnCount;
  final int delayMilliseconds;
  final gridItems;

  OverviewStaggeredGridview({
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
                              child: OverviewGridItem(
                                  gridItems.elementAt(index), index.toString())))));
            })));
  }
}