import 'package:flutter/material.dart';

import '../../../modules/cart/components/dismissible_cart_item.dart';
import '../../../modules/cart/entity/cart_item.dart';
import 'icustom_listview.dart';

class CartSimpleListview implements ICustomListview {
  @override
  Widget create(Map<String, CartItem> listItems) {
    return ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (ctx, item) {
          return DismissibleCartItem.create(listItems.values.elementAt(item));
        });
  }
}