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
  final reverse;
  final fade;
  final curve;

  CartStaggeredListview({
    this.itemCount = ITEM_COUNT,
    this.delayMilliseconds = DELAY_MILLISEC_GRIDVIEW,
    this.verticalOffset = VERTICAL_OFFSET_GRIDVIEW,
    this.reverse = false,
    this.fade = false,
    this.curve = Curves.ease,
  });

  @override
  Widget create(Map<String, CartItem> mapCartItems) {
    mapCartItems = reverse ? reverseMap(mapCartItems) : mapCartItems;
    // var total = mapCartItems.isEmpty ? 20 : mapCartItems.length;
    return AnimationLimiter(
        child: ListView.builder(
            reverse: reverse,
            itemCount: mapCartItems.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 3000),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      child: fade
                          ? FadeInAnimation(
                              curve: curve,
                              child: DismissibleCartItem.create(
                                  mapCartItems.values.elementAt(index)),
                            )
                          : DismissibleCartItem.create(
                              mapCartItems.values.elementAt(index))));
            }));
  }

  Map<String, CartItem> reverseMap(Map<String, CartItem> map) {
    var newmap = <String, CartItem>{};
    for (var i = map.length - 1; i >= 0; i--) {
      var k = map.keys.elementAt(i);
      var v = map.values.elementAt(i);
      newmap[k] = v;
    }
    return newmap;
  }
}