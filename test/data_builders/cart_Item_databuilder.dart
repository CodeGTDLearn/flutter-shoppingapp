import 'package:faker/faker.dart';
import 'package:shopingapp/app/pages_modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';

class CartItemDatabuilder {
  static CartItem CartItemFromProduct(Product product) {
    return CartItem(
        product.id,
        product.title,
        1,
        22.22);
  }

  static CartItem CartItemFull(Product product) {
    return CartItem(
        Faker().randomGenerator.string(3, min: 2),
        Faker().lorem.word(),
        Faker().hashCode,
        Faker().randomGenerator.decimal(min: 1.0));
  }
}
