import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';

import '../../../../../core/properties/properties.dart';
import '../../../../../core/utils/core_ui_utils.dart';
import '../../../entity/product.dart';
import '../custom_listtile/animated_listtile.dart';
import 'icustom_inventory_listview.dart';

class StaggeredSliverListview implements ICustomInventoryListview {
  final delayMilliseconds;
  final double verticalOffset;
  final _uiUtils = Get.find<CoreUiUtils>();

  StaggeredSliverListview({
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset = VERTICAL_OFFSET_LISTVIEW,
  });

  @override
  Widget inventoryListview(List<Product> products) {
    return AnimationLimiter(
        child: SliverList(
            delegate: SliverChildBuilderDelegate(
      (ctx, index) {
        return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: delayMilliseconds),
            child: SlideAnimation(
                verticalOffset: verticalOffset,
                child: FadeInAnimation(
                    child: AnimatedListTile().customListTile(products.elementAt(index)))));
      },
      childCount: products.length,
    )));
  }
}