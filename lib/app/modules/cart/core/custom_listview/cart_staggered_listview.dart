import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../modules/cart/entity/cart_item.dart';
import '../dismissible_cart_item.dart';
import 'icustom_cart_listview.dart';

class CartStaggeredListview implements ICustomCartListview {
  final itemCount;
  final delayMilliseconds;
  final verticalOffset;

  CartStaggeredListview({
    this.itemCount = ITEM_COUNT,
    this.delayMilliseconds = DELAY_MILLISEC_GRIDVIEW,
    this.verticalOffset = VERTICAL_OFFSET_GRIDVIEW,
  });

  @override
  Widget create(Map<String, CartItem> mapCartItems) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: mapCartItems.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: delayMilliseconds),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      child: FadeInAnimation(
                        child: DismissibleCartItem.create(
                            mapCartItems.values.elementAt(index)),
                      )));
            }));
  }
}