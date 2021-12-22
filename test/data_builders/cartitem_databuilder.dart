import 'dart:math';

import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/cart/entity/cart_item.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../config/tests_properties.dart';

class CartItemDatabuilder {
  CartItem CartItemFromProduct(Product product) {
    return CartItem(
      product.id!,
      product.title,
      1,
      22.22,
      product.imageUrl,
    );
  }

  CartItem CartItemFull() {
    return CartItem(
      "-${Faker().randomGenerator.string(21, min: 20)}",
      Faker().food.dish(),
      Faker().randomGenerator.integer(5, min: 1),
      double.parse(
        Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2),
      ),
      TEST_IMAGE_URL_MAP.values.toList()[_randomPosition],
    );
  }

  List<CartItem> cartItems() {
    List<CartItem> listCartItems;
    listCartItems = [CartItemFull(), CartItemFull()];
    return listCartItems;
  }

  final _randomPosition = Random().nextInt(TEST_IMAGE_URL_MAP.length);
}