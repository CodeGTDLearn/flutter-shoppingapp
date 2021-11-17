import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../modules/cart/components/dismissible_cart_item.dart';
import '../../../modules/cart/entity/cart_item.dart';
import 'icustom_listview.dart';

class CartStaggeredListview implements ICustomListview {
  final itemCount;
  final int delayMilliseconds;
  final verticalOffset;

  CartStaggeredListview({
    this.itemCount = 1,
    this.delayMilliseconds = 375,
    this.verticalOffset = 50.0,
  });

  @override
  Widget create(Map<String, CartItem> listItems) {
    return AnimationLimiter(
        child: ListView.builder(
            // itemCount: itemCount,
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: delayMilliseconds),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      child: FadeInAnimation(
                        child:
                            DismissibleCartItem.create(listItems.values.elementAt(index)),
                      )));
            }));
  }
}