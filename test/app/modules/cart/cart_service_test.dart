import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../../../config/bindings/cart_test_bindings.dart';
import '../../../data_builders/cartitem_databuilder.dart';
import '../../../data_builders/product_databuilder.dart';

class CartServiceTests {
  static void unit() {
    late ICartService _service;
    late Product _product1, _product2;

    setUp(() {
      CartTestBindings().bindingsBuilderMockedRepo(isWidgetTest: true);
      _product1 = ProductDataBuilder().ProductWithId();
      _product2 = ProductDataBuilder().ProductWithId();
      _service = Get.find<ICartService>();
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_service, isA<ICartService>());
      expect(_product1, isA<Product>());
      expect(_product2, isA<Product>());
    });

    test('Getting ALL products from the Cart', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);

      _service.getAllCartItems().forEach((key, value) {
        expect(key.toString(), isIn(_service.getAllCartItems()));
      });
      expect(_service.getAllCartItems().length, 2);
    });

    test('Removing specific products from the Cart', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);

      var listProductsInserted = _service.getAllCartItems();
      expect(_product1.id.toString(), isIn(listProductsInserted));
      expect(_product2.id.toString(), isIn(listProductsInserted));

      //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
      var cartItem1 = CartItemDatabuilder.CartItemFromProduct(_product1);
      _service.removeCartItem(cartItem1);
      expect(_service.getAllCartItems().length, 1);
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

      //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
      var cartItem2 = CartItemDatabuilder.CartItemFromProduct(_product2);
      _service.removeCartItem(cartItem2);
      expect(_service.getAllCartItems().length, isZero);
      _service.getAllCartItems().forEach((key, value) {
        if (key.toString() == cartItem1.id.toString()) {
          fail("Error: product 02 was found, but it must not be found");
        }
      });
    });

    test('Clearing ALL products from the Cart', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);
      expect(_service.getAllCartItems().length, 2);
      _service.clearCart();
      expect(_service.getAllCartItems().length, isZero);
    });

    test('Adding two products in the Cart', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);
      expect(_service.getAllCartItems().length, 2);
      _service.clearCart();
      expect(_service.getAllCartItems().length, isZero);
    });

    test('Undo added product', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);

      var listProductsInserted = _service.getAllCartItems();
      expect(_product1.id.toString(), isIn(listProductsInserted));
      expect(_product2.id.toString(), isIn(listProductsInserted));

      _service.addCartItemUndo(_product2);
      expect(_service.getAllCartItems().length, 1);
      expect(_product1.id.toString(), isIn(listProductsInserted));
      expect(_product2.id.toString(), isNot(isIn(listProductsInserted)));

      _service.addCartItemUndo(_product1);
      expect(_service.getAllCartItems().length, isZero);
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
      expect(_product2.id.toString(), isNot(isIn(listProductsInserted)));
    });

    test('Getting CartItems Quantity from the Cart', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);

      expect(_product1.id.toString(), isIn(_service.getAllCartItems()));
      expect(_product2.id.toString(), isIn(_service.getAllCartItems()));
      expect(_service.getAllCartItems().length, 2);
      _service.clearCart();
      expect(_service.getAllCartItems().length, isZero);
    });

    test('Getting CartItems Amount\$ from the Cart', () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product1);
      _service.addCartItem(_product2);

      expect(_service.getAllCartItems().length, 2);
      expect(_product1.id.toString(), isIn(_service.getAllCartItems()));
      expect(_product2.id.toString(), isIn(_service.getAllCartItems()));

      expect(_service.cartItemTotal$Amount(), allOf([_product1.price + _product2.price]));
    });
    // });
  }
}
