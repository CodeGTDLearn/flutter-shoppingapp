import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../custom_grid_item/animated_grid_item.dart';
import 'icustom_gridview.dart';

class StaggeredGridview implements ICustomGridview {
  StaggeredGridview();

  @override
  Widget create(int columnCount, List<dynamic> gridItems, [int delayMilliseconds = 500]) {
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
                              child: AnimatedGridItem(
                                gridItems.elementAt(index),
                                index.toString(),
                              )))));
            })));
  }
}