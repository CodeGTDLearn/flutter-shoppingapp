import 'package:faker/faker.dart';
import 'package:shopingapp/app/pages_modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';

import 'cartitem_databuilder.dart';

class OrderDatabuilder {
  static Order OrderFull() {
    List<CartItem> ListCartItemsFake = [];

    CartItem carItem1 = CartItemDatabuilder.CartItemFull();
    CartItem carItem2 = CartItemDatabuilder.CartItemFull();

    ListCartItemsFake.add(carItem1);
    ListCartItemsFake.add(carItem2);

    return Order(
      Faker().randomGenerator.decimal(scale: 1, min: 100.00).toString(),
      // "2020-11-16T12:14:43.234355",
      Faker().date.dateTime(minYear: 2019, maxYear: 2020).toString(),
      ListCartItemsFake,
      // Faker().randomGenerator.string(20, min: 20),
    );
  }
}
