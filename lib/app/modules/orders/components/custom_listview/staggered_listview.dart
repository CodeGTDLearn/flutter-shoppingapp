import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';

import '../../../../core/properties/properties.dart';
import '../../../../modules/orders/entity/order.dart';
import '../custom_tiles/icustom_order_tile.dart';
import 'icustom_orders_listview.dart';

class StaggeredListview implements ICustomOrdersListview {

  final _orderTile = Get.find<ICustomOrderTile>();
  final delayMilliseconds;
  final double verticalOffset;

  StaggeredListview({
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset = VERTICAL_OFFSET_LISTVIEW,
  });

  @override
  Widget ordersListview(List<Order> orders) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: delayMilliseconds),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      child: FadeInAnimation(
                        child: _orderTile.create(orders.elementAt(index)),
                      )));
            }));
  }
}