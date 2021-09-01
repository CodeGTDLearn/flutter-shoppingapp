import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';

import '../../../config/bindings/cart_test_bindings.dart';
import '../../../data_builders/cartitem_databuilder.dart';
import '../../../data_builders/product_databuilder.dart';
import '../../../mocked_datasource/mocked_datasource.dart';

class CartControllerTests {
  static void integration() {
    late CartController _controller;
    late Product _product1, _product2;
    late Order _order1;

    setUp(() {
      _product1 = ProductDataBuilder().ProductWithId();
      _product2 = ProductDataBuilder().ProductWithId();
      _order1 = MockedDatasource().orders().elementAt(0);

      CartTestBindings().bindingsBuilderMockedRepo(isWidgetTest: true);
      _controller = Get.find<CartController>();
    });

    test('Getting ALL products from the Cart', () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);

      _controller.getAllCartItems().forEach((key, value) {
        expect(key.toString(), isIn(_controller.getAllCartItems()));
      });
      expect(_controller.getAllCartItems().length, 2);
      expect(_controller.getQtdeCartItemsObs(), 2);
    });

    test('Removing specific products from the Cart', () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);
      expect(_controller.getQtdeCartItemsObs(), 2);

      var listProductsInserted = _controller.getAllCartItems();
      expect(_product1.id.toString(), isIn(listProductsInserted));
      expect(_product2.id.toString(), isIn(listProductsInserted));

      //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
      var cartItem1 = CartItemDatabuilder.CartItemFromProduct(_product1);
      _controller.removeCartItem(cartItem1);
      expect(_controller.getAllCartItems().length, 1);
      expect(_controller.getQtdeCartItemsObs(), 1);
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

      //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
      var cartItem2 = CartItemDatabuilder.CartItemFromProduct(_product2);
      _controller.removeCartItem(cartItem2);
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
      _controller.getAllCartItems().forEach((key, value) {
        if (key.toString() == cartItem1.id.toString()) {
          fail("Error: product 02 was found, but it must not be found");
        }
      });
    });

    test('Clearing ALL products from the Cart', () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);
      expect(_controller.getAllCartItems().length, 2);
      expect(_controller.getQtdeCartItemsObs(), 2);
      _controller.clearCart();
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
    });

    test('Adding two products in the Cart', () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);

      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);
      expect(_controller.getAllCartItems().length, 2);
      expect(_controller.getQtdeCartItemsObs(), 2);
      _controller.clearCart();

      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
    });

    test('Undo added product', () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);

      var listProductsInserted = _controller.getAllCartItems();
      expect(_product1.id.toString(), isIn(listProductsInserted));
      expect(_product2.id.toString(), isIn(listProductsInserted));

      _controller.addCartItemUndo(_product2);
      expect(_controller.getAllCartItems().length, 1);
      expect(_controller.getQtdeCartItemsObs(), 1);
      expect(_product1.id.toString(), isIn(listProductsInserted));
      expect(_product2.id.toString(), isNot(isIn(listProductsInserted)));

      _controller.addCartItemUndo(_product1);
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.getQtdeCartItemsObs(), isZero);
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
      expect(_product2.id.toString(), isNot(isIn(listProductsInserted)));
    });

    test('Getting CartItems QuantityObs from the Cart', () {
      expect(_controller.getQtdeCartItemsObs(), isZero);
      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);

      expect(_product1.id.toString(), isIn(_controller.getAllCartItems()));
      expect(_product2.id.toString(), isIn(_controller.getAllCartItems()));
      expect(_controller.getQtdeCartItemsObs(), 2);
      _controller.clearCart();
      expect(_controller.getQtdeCartItemsObs(), isZero);
    });

    test('Getting CartItems AmountObs\$ from the Cart', () {
      expect(_controller.getAllCartItems().length, isZero);
      _controller.addCartItem(_product1);
      _controller.addCartItem(_product2);

      expect(_controller.getAllCartItems().length, 2);
      expect(_product1.id.toString(), isIn(_controller.getAllCartItems()));
      expect(_product2.id.toString(), isIn(_controller.getAllCartItems()));

      expect(_controller.getAmountCartItemsObs(), _product1.price + _product2.price);
    });

    test('Adding Orders', () {
      _controller
          .addOrder(_order1.cartItems, double.parse(_order1.amount))
          .then((orderReturned) {
        expect(orderReturned.id, _order1.id);
        expect(orderReturned.cartItems[0].id, _order1.cartItems[0].id);
        expect(orderReturned.cartItems[1].id, _order1.cartItems[1].id);
      });
    });
  }
}
