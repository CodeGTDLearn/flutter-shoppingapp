import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../../../config/data_builders/cartitem_databuilder.dart';
import '../../../config/data_builders/product_databuilder.dart';
import 'core/cart_test_bindings.dart';
import 'core/cart_test_titles.dart';

class CartServiceTests {
  void unit() {
    late ICartService _service;
    late Product _product0, _product1;
    final _titles = Get.find<CartTestTitles>();
    final _builder = Get.put(ProductDataBuilder());

    setUp(() {
      Get.put(CartTestBindings());
      Get.find<CartTestBindings>().bindingsBuilder(isWidgetTest: true);
      _service = Get.find<ICartService>();
      _product0 = _builder.ProductWithId();
      _product1 = _builder.ProductWithId();
    });

    test(_titles.service_get_all_products, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);

      _service.getAllCartItems().forEach((key, value) {
        expect(key.toString(), isIn(_service.getAllCartItems()));
      });
      expect(_service.getAllCartItems().length, 2);
    });

    test(_titles.service_remove_product, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);

      var listProductsInserted = _service.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
      var cartItem1 = CartItemDatabuilder().CartItemFromProduct(_product0);
      _service.removeCartItem(cartItem1);
      expect(_service.getAllCartItems().length, 1);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));

      //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
      var cartItem2 = CartItemDatabuilder().CartItemFromProduct(_product1);
      _service.removeCartItem(cartItem2);
      expect(_service.getAllCartItems().length, isZero);
      _service.getAllCartItems().forEach((key, value) {
        if (key.toString() == cartItem1.id.toString()) {
          fail("Error: product 02 was found, but it must not be found");
        }
      });
    });

    test(_titles.service_clear_cart, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);
      expect(_service.getAllCartItems().length, 2);
      _service.clearCart();
      expect(_service.getAllCartItems().length, isZero);
    });

    test(_titles.service_add_two_products, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);
      expect(_service.getAllCartItems().length, 2);
      _service.clearCart();
      expect(_service.getAllCartItems().length, isZero);
    });

    test(_titles.service_undo_add_product, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);

      var listProductsInserted = _service.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      _service.addCartItemUndo(_product1);
      expect(_service.getAllCartItems().length, 1);
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

      _service.addCartItemUndo(_product0);
      expect(_service.getAllCartItems().length, isZero);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
    });

    test(_titles.service_get_cartitem_qtde, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);

      expect(_product0.id.toString(), isIn(_service.getAllCartItems()));
      expect(_product1.id.toString(), isIn(_service.getAllCartItems()));
      expect(_service.getAllCartItems().length, 2);
      _service.clearCart();
      expect(_service.getAllCartItems().length, isZero);
    });

    test(_titles.service_get_cartitem_amount, () {
      expect(_service.getAllCartItems().length, isZero);
      _service.addCartItem(_product0);
      _service.addCartItem(_product1);

      expect(_service.getAllCartItems().length, 2);
      expect(_product0.id.toString(), isIn(_service.getAllCartItems()));
      expect(_product1.id.toString(), isIn(_service.getAllCartItems()));

      expect(_service.amountCartItems(_service.getAllCartItems()),
          allOf([_product0.price + _product1.price]));
    });
  }
}