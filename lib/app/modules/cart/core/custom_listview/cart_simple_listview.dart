import 'package:flutter/material.dart';

import '../../../../modules/cart/entity/cart_item.dart';
import '../dismissible_cart_item.dart';
import 'icustom_cart_listview.dart';

class CartSimpleListview implements ICustomCartListview {
  @override
  Widget create(Map<String, CartItem> mapCartItems) {
    return ListView.builder(
        itemCount: mapCartItems.length,
        itemBuilder: (ctx, item) {
          return DismissibleCartItem.create(mapCartItems.values.elementAt(item));
        });
  }
}