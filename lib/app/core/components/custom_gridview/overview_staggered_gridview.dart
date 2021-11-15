import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';

import '../../../modules/overview/components/overview_grid_item.dart';
import '../../../modules/overview/controller/overview_controller.dart';
import 'icustom_gridview.dart';

class OverviewStaggeredGridview implements ICustomGridview {
  final _controller = Get.find<OverviewController>();
  final columnCount;
  final int delayMilliseconds;

  OverviewStaggeredGridview({this.columnCount = 1, this.delayMilliseconds = 500});

  @override
  Widget create() {
    return AnimationLimiter(
        child: GridView.count(
            crossAxisCount: columnCount,
            children:
                List.generate(_controller.overviewViewGridViewItemsObs.length, (index) {
              return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: columnCount,
                  child: ScaleAnimation(
                    duration: Duration(milliseconds: delayMilliseconds),
                    child: FadeInAnimation(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OverviewGridItem(
                          _controller.overviewViewGridViewItemsObs[index],
                          index.toString()),
                    )),
                  ));
            })));
  }
}