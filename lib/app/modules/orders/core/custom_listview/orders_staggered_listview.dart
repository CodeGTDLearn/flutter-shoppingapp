import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../modules/orders/entity/order.dart';
import '../order_collapsable_tile.dart';
import 'icustom_orders_listview.dart';

class OrdersStaggeredListview implements ICustomOrdersListview {
  final itemCount;
  final delayMilliseconds;
  final double verticalOffset;

  OrdersStaggeredListview({
    this.itemCount = ITEM_COUNT,
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset = VERTICAL_OFFSET_LISTVIEW,
  });

  @override
  Widget create(List<Order> ordersList) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: ordersList.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: delayMilliseconds),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      child: FadeInAnimation(
                        child: OrderCollapsableTile(ordersList.elementAt(index)),
                      )));
            }));
  }
}