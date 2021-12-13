import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../modules/orders/entity/order.dart';
import '../custom_collapsable_tile/order_collapsable_tile.dart';
import 'icustom_orders_listview.dart';

class StaggeredListview implements ICustomOrdersListview {
  final delayMilliseconds;
  final double verticalOffset;

  StaggeredListview({
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset = VERTICAL_OFFSET_LISTVIEW,
  });

  @override
  Widget customOrdersListview(List<Order> ordersList) {
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