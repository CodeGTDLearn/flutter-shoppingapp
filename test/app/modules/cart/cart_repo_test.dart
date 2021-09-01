import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';

import '../../../config/bindings/cart_test_bindings.dart';
import '../../../data_builders/cartitem_databuilder.dart';
import '../../../mocked_datasource/mocked_datasource.dart';

/*
 THERE IS NO NECESSITY OF _injectableRepoMock
 BECAUSE THERE IS NO 'CALLBACKS' FROM, WETHER DATABASE OR HTTP-CALLS
 (NAO EXISTE NECESSIDADE DE _injectableRepoMock
 POIS NAO EXISTEM 'CALLBACKS' DE DATABASE OU CHAMADAS-HTTP)
 */
class CartRepoTests {
  static void unit() {
    late ICartRepo _repo;
    var _product0 = MockedDatasource().products().elementAt(0);
    var _product1 = MockedDatasource().products().elementAt(1);

    setUp(() {
      CartTestBindings().bindingsBuilderMockedRepo(isWidgetTest: true);
      _repo = Get.find<ICartRepo>();
      _repo.addCartItem(_product0);
      _repo.addCartItem(_product1);
    });

    test('Getting ALL products from the Cart', () {
      _repo.getAllCartItems().forEach((key, value) {
        expect(key.toString(), isIn(_repo.getAllCartItems()));
      });
      expect(_repo.getAllCartItems().length, 2);
    });

    test('Removing specific products from the Cart', () {
      var listProductsInserted = _repo.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      //TESTING ABSENCE: STYLE 01 - ISNOT+ISIN
      var cartItem1 = CartItemDatabuilder.CartItemFromProduct(_product0);
      _repo.removeCartItem(cartItem1);
      expect(_repo.getAllCartItems().length, 1);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));

      //TESTING ABSENCE: STYLE 02 - FOREACH+FAIL
      var cartItem2 = CartItemDatabuilder.CartItemFromProduct(_product1);
      _repo.removeCartItem(cartItem2);
      expect(_repo.getAllCartItems().length, isZero);
      _repo.getAllCartItems().forEach((key, value) {
        if (key.toString() == cartItem1.id.toString()) {
          fail("Error: product 02 was found, but it must not be found");
        }
      });
    });

    test('Clearing ALL products from the Cart', () {
      expect(_repo.getAllCartItems().length, 2);
      _repo.clearCart();
      expect(_repo.getAllCartItems().length, isZero);
    });

    test('Adding two products in the Cart', () {
      expect(_repo.getAllCartItems().length, 2);
      _repo.clearCart();
      expect(_repo.getAllCartItems().length, isZero);
    });

    test('Undo added product', () {
      var listProductsInserted = _repo.getAllCartItems();
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isIn(listProductsInserted));

      _repo.addCartItemUndo(_product1);
      expect(_repo.getAllCartItems().length, 1);
      expect(_product0.id.toString(), isIn(listProductsInserted));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));

      _repo.addCartItemUndo(_product0);
      expect(_repo.getAllCartItems().length, isZero);
      expect(_product0.id.toString(), isNot(isIn(listProductsInserted)));
      expect(_product1.id.toString(), isNot(isIn(listProductsInserted)));
    });
  }
}
