import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/cart/entity/cart_item.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';

import 'cartitem_databuilder.dart';

class OrderDatabuilder {
  Order Order_full_withoutId() {
    var _listCartItemsFake = <CartItem>[];

    var carItem1 = CartItemDatabuilder().CartItemFull();
    var carItem2 = CartItemDatabuilder().CartItemFull();

    _listCartItemsFake.add(carItem1);
    _listCartItemsFake.add(carItem2);

    return Order(
        id: null,
        amount: Faker().randomGenerator.decimal(scale: 1, min: 100.00).toString(),
        datetime: Faker().date.dateTime(minYear: 2019, maxYear: 2020).toString(),
        cartItems: _listCartItemsFake);
  }

  Order Order_full_withId() {
    var _listCartItemsFake = <CartItem>[];

    var carItem1 = CartItemDatabuilder().CartItemFull();
    var carItem2 = CartItemDatabuilder().CartItemFull();

    _listCartItemsFake.add(carItem1);
    _listCartItemsFake.add(carItem2);

    return Order(
        id: Faker().randomGenerator.string(21, min: 20),
        amount: Faker().randomGenerator.decimal(scale: 1, min: 100.00).toString(),
        datetime: Faker().date.dateTime(minYear: 2019, maxYear: 2020).toString(),
        cartItems: _listCartItemsFake);
  }

  static Order OrderParam(List<CartItem> cartItems, String id) {
    return Order(
      id: id,
      amount: Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2),
      datetime: Faker().date.dateTime(minYear: 2019, maxYear: 2020).toString(),
      cartItems: cartItems,
    );
  }
}