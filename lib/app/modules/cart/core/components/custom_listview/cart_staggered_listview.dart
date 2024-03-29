import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// erro Gradle + flutter_staggered_animations:
// Script 'C:\flutter\packages\flutter_tools\gradle\flutter.gradle' line: 1005
// Solution:
// a) dart pub get;
// b) flutter pub cache repair;
// c) flutter clean;
// d) flutter pub get;
// e) dart pub cache clean.
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../core/properties/properties.dart';
import '../../../entity/cart_item.dart';
import '../dismissible_cart_item.dart';
import 'icustom_cart_listview.dart';

class CartStaggeredListview implements ICustomCartListview {
  final itemCount;
  final delayMilliseconds;
  final verticalOffset;
  final horizontalOffset;
  final invertTargetPosition;
  final fadeEffect;
  final fadeCurve;

  CartStaggeredListview({
    this.itemCount = ITEM_COUNT,
    this.delayMilliseconds = DELAY_MILLISEC_LISTVIEW,
    this.verticalOffset,
    this.horizontalOffset,
    this.invertTargetPosition = false,
    this.fadeEffect = false,
    this.fadeCurve = Curves.ease,
  });

  @override
  Widget listview(Map<String, CartItem> cartItems) {
    cartItems = invertTargetPosition ? reverseMap(cartItems) : cartItems;
    return AnimationLimiter(
        child: ListView.builder(
            reverse: invertTargetPosition,
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: DELAY_MILLISEC_LISTVIEW),
                  child: SlideAnimation(
                      verticalOffset: verticalOffset,
                      horizontalOffset: horizontalOffset,
                      child: fadeEffect
                          ? () {
                              var item = cartItems.values.elementAt(index);
                              return FadeInAnimation(
                                  curve: fadeCurve,
                                  child: DismissibleCartItem.create(item));
                            }.call()
                          : () {
                              var item = cartItems.values.elementAt(index);
                              return DismissibleCartItem.create(item);
                            }.call()));
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