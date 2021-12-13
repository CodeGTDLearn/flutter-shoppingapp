import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../modules/inventory/entity/product.dart';
import '../custom_listtile/animated_listtile.dart';
import 'icustom_inventory_listview.dart';

class StaggeredListview implements ICustomInventoryListview {
  final itemCount;
  final delayMilliseconds;
  final double verticalOffset;

  StaggeredListview({
    this.itemCount = ITEM_COUNT,
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset = VERTICAL_OFFSET_LISTVIEW,
  });

  @override
  Widget customInventoryListview(List<Product> products) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: delayMilliseconds),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      child: FadeInAnimation(
                          child: AnimatedListTile().customListTile(products.elementAt(index)))));
            }));
  }
}