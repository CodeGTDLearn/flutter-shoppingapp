import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../modules/cart/entity/cart_item.dart';
import 'EmptyCard.dart';
import 'icustom_cart_listview.dart';

class CartStaggeredListview2 implements ICustomCartListview {
  final itemCount;
  final delayMilliseconds;
  final verticalOffset;

  CartStaggeredListview2({
    this.itemCount = ITEM_COUNT,
    this.delayMilliseconds = DELAY_MILLISEC_GRIDVIEW,
    this.verticalOffset = VERTICAL_OFFSET_GRIDVIEW,
  });

  @override
  Widget create(Map<String, CartItem> mapCartItems) {
    var total = mapCartItems.isEmpty ? 3 : mapCartItems.length;
    return AnimationLimiter(
        child: ListView.builder(
            // itemCount: mapCartItems.length,
            itemCount: total,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: delayMilliseconds),
                  child: SlideAnimation(
                      duration: Duration(milliseconds: delayMilliseconds),
                      verticalOffset: verticalOffset,
                      child: FadeInAnimation(
                        duration: Duration(milliseconds: delayMilliseconds),
                        child: EmptyCard(
                            width: MediaQuery.of(context).size.width, height: 88.0),
                      )));
            }));
  }
}