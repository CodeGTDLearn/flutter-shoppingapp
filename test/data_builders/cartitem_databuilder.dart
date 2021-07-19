import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

class CartItemDatabuilder {
  static CartItem CartItemFromProduct(Product product) {
    return CartItem(product.id!, product.title, 1, 22.22);
  }

  static CartItem CartItemFull() {
    var _price =
        double.parse(Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2));

    return CartItem("-${Faker().randomGenerator.string(21, min: 20)}",
        Faker().food.dish(), Faker().randomGenerator.integer(5, min: 1), _price);
  }

  static List<CartItem> cartItems() {
    List<CartItem> listCartItems;
    listCartItems = [CartItemFull(), CartItemFull()];
    return listCartItems;
  }
}
