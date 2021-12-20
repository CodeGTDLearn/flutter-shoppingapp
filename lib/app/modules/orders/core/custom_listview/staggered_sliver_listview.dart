import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../modules/orders/entity/order.dart';
import '../custom_tiles/expandable_tile.dart';
import 'icustom_orders_listview.dart';

class StaggeredSliverListview implements ICustomOrdersListview {
  final delayMilliseconds;
  final double verticalOffset;

  StaggeredSliverListview({
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset = VERTICAL_OFFSET_LISTVIEW,
  });

  @override
  Widget ordersListview(List<Order> orders) {
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
                  // child: OrderCollapsableTile(orders.elementAt(index)),
                  child: ExpandableTile(orders.elementAt(index)),
                )));
      },
      childCount: orders.length,


    )));
  }
}