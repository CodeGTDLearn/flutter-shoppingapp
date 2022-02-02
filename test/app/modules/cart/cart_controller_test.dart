import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';

import '../../../config/data_builders/cartitem_databuilder.dart';
import '../../../config/data_builders/product_databuilder.dart';
import '../../../config/datasource/mocked_datasource.dart';
import 'core/cart_test_bindings.dart';
import 'core/cart_test_titles.dart';

class CartControllerTests {
  void integration() {
    late CartController _controller;
    late Product _product0, _product1;
    late Order _order1;
    final _titles = Get.find<CartTestTitles>();
    final _builder = Get.find<ProductDataBuilder>();
    final _mock = Get.find<MockedDatasource>();

    setUp(() {
      Get.create(() => CartTestBindings());
      Get.find<CartTestBindings>().bindingsBuilder(isWidgetTest: true);
      _controller = Get.find<CartController>();
      _product0 = _builder.ProductWithId();
      _product1 = _builder.ProductWithId();
      _order1 = _mock.orders().elementAt(0);
    });

    test(_titles.controller_get_all_products, () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);

      _controller.getAllCartItems().forEach((key, value) {
        expect(key.toString(), isIn(_controller.getAllCartItems()));
      });
      expect(_controller.getAllCartItems().length, 2);
      expect(_controller.qtdeCartItemsObs.value, 2);
    });

    test(_titles.controller_product, () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);
      expect(_controller.qtdeCartItemsObs.value, 2);

      var listProductsInserted = _controller.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
      var cartItem1 = CartItemDatabuilder().CartItemFromProduct(_product0);
      _controller.removeCartItem(cartItem1);
      expect(_controller.getAllCartItems().length, 1);
      expect(_controller.qtdeCartItemsObs.value, 1);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));

      //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
      var cartItem2 = CartItemDatabuilder().CartItemFromProduct(_product1);
      _controller.removeCartItem(cartItem2);
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
      _controller.getAllCartItems().forEach((key, value) {
        if (key.toString() == cartItem1.id.toString()) {
          fail("Error: product 02 was found, but it must not be found");
        }
      });
    });

    test(_titles.controller_clear_cart, () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);
      expect(_controller.getAllCartItems().length, 2);
      expect(_controller.qtdeCartItemsObs.value, 2);
      _controller.clearCart();
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
    });

    test(_titles.controller_add_two_products, () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);

      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);
      expect(_controller.getAllCartItems().length, 2);
      expect(_controller.qtdeCartItemsObs.value, 2);
      _controller.clearCart();

      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
    });

    test(_titles.controller_undo_add_product, () {
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);

      var listProductsInserted = _controller.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      _controller.addCartItemUndo(_product1);
      expect(_controller.getAllCartItems().length, 1);
      expect(_controller.qtdeCartItemsObs.value, 1);
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

      _controller.addCartItemUndo(_product0);
      expect(_controller.getAllCartItems().length, isZero);
      expect(_controller.qtdeCartItemsObs.value, isZero);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
    });

    test(_titles.controller_get_cartitem_qtde, () {
      expect(_controller.qtdeCartItemsObs.value, isZero);
      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);

      expect(_product0.id.toString(), isIn(_controller.getAllCartItems()));
      expect(_product1.id.toString(), isIn(_controller.getAllCartItems()));
      expect(_controller.qtdeCartItemsObs.value, 2);
      _controller.clearCart();
      expect(_controller.qtdeCartItemsObs.value, isZero);
    });

    test(_titles.controller_get_cartitem_amount, () {
      expect(_controller.getAllCartItems().length, isZero);
      _controller.addCartItem(_product0);
      _controller.addCartItem(_product1);

      expect(_controller.getAllCartItems().length, 2);
      expect(_product0.id.toString(), isIn(_controller.getAllCartItems()));
      expect(_product1.id.toString(), isIn(_controller.getAllCartItems()));

      expect(_controller.amountCartItemsObs.value, _product0.price + _product1.price);
    });

    test(_titles.controller_add_order, () {
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