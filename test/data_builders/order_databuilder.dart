import 'package:faker/faker.dart';
import 'package:shopingapp/app/pages_modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';

import 'cartitem_databuilder.dart';

class OrderDatabuilder {
  static Order OrderFull() {
    List<CartItem> ListCartItemsFake = [];

    var carItem1 = CartItemDatabuilder.CartItemFull();
    var carItem2 = CartItemDatabuilder.CartItemFull();

    ListCartItemsFake.add(carItem1);
    ListCartItemsFake.add(carItem2);

    return Order(
        Faker().randomGenerator.decimal(scale: 1, min: 100.00).toString(),
        Faker().date.dateTime(minYear: 2019, maxYear: 2020).toString(),
        ListCartItemsFake);
  }

  static Order OrderParam(List<CartItem> cartItems, String id) {
    return Order(
        Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2),
        Faker().date.dateTime(minYear: 2019, maxYear: 2020).toString(),
        cartItems,
        id);
  }
}
