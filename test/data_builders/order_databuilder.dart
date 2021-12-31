import 'dart:math';

import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/cart/entity/cart_item.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';

import '../config/app_tests_properties.dart';
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
    var _cartItems = <CartItem>[];
    var year = DateTime.now().year;

    var order = Order(
        id: Faker().randomGenerator.string(21, min: 20),
        amount: Faker().randomGenerator.decimal(scale: 1, min: 100.00).toStringAsFixed(2),
        datetime: Faker().date.dateTime(minYear: year - 1, maxYear: year).toString(),
        cartItems: _cartItems);

    var randomQtdeCartItems =
        Random().nextInt(TOTAL_CART_ITEMS_INSIDE_PRODUCTS_SAMPLE_DATA);
    for (var i = 0; i < randomQtdeCartItems + 1; i++) {
      _cartItems.add(CartItemDatabuilder().CartItemFull());
    }

    order.cartItems = _cartItems;

    return order;
  }

  Order OrderId_with_ProductList(List<Object> products) {
    var _cartItems = <CartItem>[];
    var year = DateTime.now().year;

    var order = Order(
        id: Faker().randomGenerator.string(21, min: 20),
        amount: Faker().randomGenerator.decimal(scale: 1, min: 100.00).toStringAsFixed(2),
        datetime: Faker().date.dateTime(minYear: year - 1, maxYear: year).toString(),
        cartItems: _cartItems);

    var randomQtdeCartItems =
        Random().nextInt(TOTAL_CART_ITEMS_INSIDE_PRODUCTS_SAMPLE_DATA);
    for (var i = 0; i < randomQtdeCartItems + 1; i++) {
      _cartItems.add(
        CartItemDatabuilder().CartItemFromProduct(
          products.elementAt(Random().nextInt(products.length)) as Product,
        ),
      );
    }

    order.cartItems = _cartItems;

    return order;
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